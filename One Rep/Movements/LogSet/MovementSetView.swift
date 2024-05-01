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
    @State private var listOfDates = [String]()
    @State private var logsByDate = [String: [Log]]()
    @State private var setTypeSelection: RepType = .WorkingSet
    @State private var setTypeColorDark = Color(Colors.DarkBlue.description)
    @State private var setTypeColorLight = Color(Colors.LightBlue.description)
    @State private var isBodyWeightSelected = false
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
                        HStack {
                            Spacer()
                            SetTypePicker(setTypeSelection: $setTypeSelection, setTypeColorDark: $setTypeColorDark, setTypeColorLight: $setTypeColorLight)
                            Spacer()
                        }
                        HStack(spacing: 8) {
                            MutateWeightView(weight: $weight, weightStr: $weightStr, isInputActive: _isInputActive, color: Color(setTypeColorLight))
                            if setTypeSelection != .PR {
                                Spacer()
                                MutateRepsView(reps: $reps, repsStr: $repsStr, isInputActive: _isInputActive, color: Color(setTypeColorLight))
                            }
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
                        LogSetButton(movement: movement,
                                     setTypeSelection: $setTypeSelection,
                                     setTypeColorDark: $setTypeColorDark,
                                     setTypeColorLight: $setTypeColorLight,
                                     addLogToRealm: addLogToRealm)
                        .padding(.top, 8)
                    }
                    .padding(.vertical, 24)
                    .background(Color(Colors.BackgroundElementColor.description))
                    Divider()
                        .frame(height: 1.5)
                        .padding(.top, -8)
                }
                ScrollView(showsIndicators: false) {
                    ForEach(0..<listOfDates.count, id: \.self) { i in
                        let date = listOfDates[i]
                        Section(header:
                                    HStack {
                            if i == 0 {
                                ShowScrollViewButton(showLogSetView: $showLogSetView)
                            }
                            Spacer()
                            Text(date)
                                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                                .foregroundColor(.primary)}
                            .padding(.horizontal, 16)
                            .padding(.bottom, 8)) {
                                ForEach(logsByDate[date] ?? [], id: \.id) { log in
                                    let weightStr = convertWeightDoubleToString(weight: log.weight)
                                    LogCard(repType: log.repType,
                                            weight: weightStr,
                                            reps: String(log.reps))
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
            populatelistOfDates()
            populateLogsByDate()
        }
    }
    
    // MARK: - Functions
    
    private func addLogToRealm() {
        let log = Log(reps: reps, weight: weight, isBodyWeight: false, repType: setTypeSelection, date: Date().timeIntervalSince1970 + 86400)
        if let thawedMovementLogList = movement.logs.thaw() {
            do {
                try realm.write {
                    thawedMovementLogList.append(log)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        populatelistOfDates()
                        populateLogsByDate()
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
    private func populatelistOfDates() {
        listOfDates = []
        for log in movement.logs.sorted(by: \Log.date, ascending: false) {
            let stringDate = formatDate(date: log.date)
            if !self.listOfDates.contains(stringDate) {
                self.listOfDates.append(stringDate)
            }
        }
    }
    
    /// Populate logsByDate where the key = date and val = array of logs
    private func populateLogsByDate() {
        logsByDate = [:]
        for date in self.listOfDates { /// Create all dict keys with empty lists
            self.logsByDate[date] = []
        }
        for log in movement.logs.sorted(by: \Log.date, ascending: false) {
            let stringDate = formatDate(date: log.date)
            if self.listOfDates.contains(stringDate) {
                self.logsByDate[stringDate]?.append(log)
            }
        }
    }
    
    /// Take float and convert to 0 or 1 decimal string
    private func convertWeightDoubleToString(weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
}

struct ShowScrollViewButton: View {
    
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
                    .frame(width: 36, height: 24)
                    .cornerRadius(8)
                Image(systemName: icon)
                    .foregroundColor(.primary)
                    .font(.title3.weight(.bold))
            }
        })
    }
}
