//
//  SetView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI
import RealmSwift

struct MovementSetView: View {
    
    // MARK: - Variables
    @Environment(\.realm) var realm
    
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var movementModel: MovementViewModel
    @ObservedRealmObject var movement: Movement
    
    @State private var reps: Int = 12
    @State private var repsStr = "12"
    
    @State private var weight: Double = 135
    @State private var weightStr = "135"
    @State private var weightSelection = "All"
    @State private var listOfWeights = [String]()
    @State private var recentLog: Log? = nil
    
    @State private var listOfDates = [String]()
    @State private var logsByDate = [String: [Log]]()
    
    @State private var showEditMovementPopup = false
    @State private var showDoneToolBar = true
    @State private var showLogSetView = true
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.BackgroundColor)
                .ignoresSafeArea()
            VStack {
                if showLogSetView {
                    VStack(alignment: .center, spacing: 16) {
                        HStack(spacing: 8) {
                            MutateWeightView(weight: $weight, weightStr: $weightStr, isInputActive: _isInputActive)
                            MutateRepsView(reps: $reps, repsStr: $repsStr, isInputActive: _isInputActive)
                        }
                        .toolbar {
                            if showDoneToolBar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        isInputActive = false
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        LogSetButton(movement: movement, addLogToRealm: addLogToRealm, setMostRecentLog: setMostRecentLog)
                            .padding(.top, 8)
                    }
                    .padding(.vertical, 24)
                    .background(Color(theme.BackgroundElementColor))
                    Divider()
                        .padding(.top, -8)
                }
                
                ScrollView(showsIndicators: false) {
                    
                    if movement.logs.count != 0 {
                        WeightHorizontalScroller(weightSelection: $weightSelection, listOfWeights: $listOfWeights, filterWeightAndPopulateData: filterWeightAndPopulateData, setMostRecentLog: setMostRecentLog)
                    } else {
                        Text(InfoText.NoData.description)
                            .customFont(size: .body, weight: .regular, kerning: 0, design: .rounded)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.top, 32)
                    }
                    
                    ForEach(0..<listOfDates.count, id: \.self) { index in
                        let date = listOfDates[index]
                        Section(header: HStack {
                            Text(date)
                                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                                .foregroundColor(.primary)
                            Spacer()
                            if index == 0 {
                                ShowFullScreenButton(showLogSetView: $showLogSetView)
                            }
                        }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        ){
                                ForEach(logsByDate[date] ?? [], id: \.id) { log in
                                    let weightStr = convertWeightDoubleToString(log.weight)
                                    LogCard(weight: weightStr,
                                            reps: String(log.reps),
                                            date: log.date)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 8)
                                }
                            /// Delete log
                            .onDelete { offsets in
                                /// isScreenDisabled = true
                                let logItem = (logsByDate[date] ?? [])[offsets.first ?? 0]
                                /// deleteLog(logItem: logItem)
                            }
                        }
                    }
                }
                .padding(.top, showLogSetView ? 0 : 16)
            }
            .sheet(isPresented: $showEditMovementPopup) {
                EditMovementView(movement: movement, movementModel: movementModel, showDoneToolBar: $showDoneToolBar)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditMovementButton(showEditMovementPopup: $showEditMovementPopup, showDoneToolBar: $showDoneToolBar)
                }
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 14) {
                        Image(movement.muscleGroup.rawValue.lowercased())
                            .font(.caption2)
                            .foregroundStyle(.linearGradient(colors: [
                                Color(theme.lightBaseColor),
                                Color(theme.darkBaseColor)
                            ], startPoint: .top, endPoint: .bottom))
                        Text(movement.name)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            populateListOfWeights()
            filterWeightAndPopulateData()
            setMostRecentLog()
        }
    }
    
    // MARK: - Functions
    
    private func addLogToRealm() {
        let log = Log(reps: reps, weight: weight, isBodyWeight: false, date: Date().timeIntervalSince1970 + 86400)
        if let thawedMovementLogList = movement.logs.thaw() {
            do {
                try realm.write {
                    thawedMovementLogList.append(log)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        populateListOfWeights()
                        filterWeightAndPopulateData()
                    }
                }
            } catch  {
                /// Handle error
            }
        }
    }
    
    /// Format date for section header Ex. Apr 24, 2024
    private func formatDate(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    /// Populate listOfDates with unique dates and sort
    private func populatelistOfDates(_ logs: Results<Log>) {
        listOfDates = []
        for log in logs {
            let stringDate = formatDate(date: log.date)
            if !self.listOfDates.contains(stringDate) {
                self.listOfDates.append(stringDate)
            }
        }
    }
    
    /// Populate logsByDate where the key = date and val = array of logs
    private func populateLogsByDate(_ logs: Results<Log>) {
        logsByDate = [:]
        for date in self.listOfDates { /// Create all dict keys with empty lists
            self.logsByDate[date] = []
        }
        for log in logs {
            let stringDate = formatDate(date: log.date)
            if self.listOfDates.contains(stringDate) {
                self.logsByDate[stringDate]?.append(log)
            }
        }
    }
    
    /// Populate list of weights with all unique weights
    private func populateListOfWeights() {
        listOfWeights = []
        for log in movement.logs {
            let weight = convertWeightDoubleToString(log.weight)
            if !listOfWeights.contains(weight) {
                listOfWeights.append(weight)
            }
        }
        listOfWeights.sort{$0.localizedStandardCompare($1) == .orderedAscending}
        listOfWeights.insert("All", at: 0)
    }
    
    /// Populate data based on filter for weight
    private func filterWeightAndPopulateData() {
        if weightSelection != "All" {
            let weight = (weightSelection as NSString).doubleValue
            let filteredLogs = movement.logs.sorted(by: \Log.date, ascending: false).where {
                ($0.weight == weight)
            }
            populatelistOfDates(filteredLogs)
            populateLogsByDate(filteredLogs)
        } else {
            populatelistOfDates(movement.logs.sorted(by: \Log.date, ascending: false))
            populateLogsByDate(movement.logs.sorted(by: \Log.date, ascending: false))
        }
    }
    
    private func setMostRecentLog() {
        var logs = movement.logs.sorted(by: \Log.date, ascending: false)
        if weightSelection != "All" {
            logs = movement.logs.sorted(by: \Log.date, ascending: false).where {
                ($0.weight == Double(weightSelection) ?? 0)
            }
        }
        recentLog = logs.first
        reps = recentLog?.reps ?? 12
        repsStr = String(recentLog?.reps ?? 12)
        weight = recentLog?.weight ?? 135
        weightStr = String(recentLog?.weight ?? 135)
    }
    
    /// Take float and convert to 0 or 1 decimal string
    private func convertWeightDoubleToString(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
}

struct ShowFullScreenButton: View {
    
    @EnvironmentObject var theme: ThemeModel
    
    @State var icon = "chevron.compact.up"
    
    @Binding var showLogSetView: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.showLogSetView.toggle()
                if showLogSetView {
                    icon = "chevron.compact.up"
                } else {
                    icon = "chevron.compact.down"
                }
            }
        }, label: {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(theme.BackgroundElementColor))
                    .frame(width: 40, height: 28)
                    .cornerRadius(8)
                Image(systemName: icon)
                    .foregroundColor(.primary)
                    .font(.title3.weight(.semibold))
            }
        })
    }
}
