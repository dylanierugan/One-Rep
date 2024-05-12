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
    @EnvironmentObject var logDataController: LogDataController
    
    @ObservedRealmObject var movementModel: MovementViewModel
    @ObservedRealmObject var movement: Movement
    @State var selectedLog: Log = Log()
    
    @State private var showEditMovementPopup = false
    @State private var showDoneToolBar = true
    @State private var showLogSetView = true
    @State private var isEditingLogs = false
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
            VStack {
                if showLogSetView {
                    VStack(alignment: .center, spacing: 16) {
                        HStack(spacing: 8) {
                            MutateWeightView(isInputActive: _isInputActive)
                            MutateRepsView(isInputActive: _isInputActive)
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
                        
                        LogSetButton(movement: movement, addLogToRealm: addLogToRealm)
                            .padding(.top, 8)
                    }
                    .padding(.vertical, 24)
                    .background(Color(theme.backgroundElementColor))
                    Divider()
                        .padding(.top, -8)
                }
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 16) {
                        if movement.logs.count != 0 {
                            WeightHorizontalScroller(movement: movement)
                        } else {
                            HStack {
                                Spacer()
                                Text(InfoText.NoData.description)
                                    .customFont(size: .body, weight: .regular, kerning: 0, design: .rounded)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.secondary)
                                    .padding(.top, 32)
                                Spacer()
                            }
                        }
                        
                        ForEach(0..<logDataController.listOfDates.count, id: \.self) { index in
                            let date = logDataController.listOfDates[index]
                            Section(header: HStack {
                                Text(date)
                                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                                    .foregroundColor(.primary)
                                Spacer()
                                if index == 0 {
                                    EditLogButton(isEditingLogs: $isEditingLogs)
                                        .padding(.horizontal, 8)
                                    ShowFullScreenButton(showLogSetView: $showLogSetView)
                                }
                            }
                                .padding(.horizontal, 16)
                            ){
                                ForEach(logDataController.logsByDate[date] ?? [], id: \.id) { log in
                                    let weightStr = logDataController.convertWeightDoubleToString(log.weight)
                                    HStack(spacing: 16) {
                                        LogCard(weight: weightStr,
                                                reps: String(log.reps),
                                                date: log.date)
                                        if isEditingLogs {
                                            DeleteLogButton(movement: movement,
                                                            log: log,
                                                            selectedLog: $selectedLog,
                                                            deleteLogInRealm: { self.deleteLogInRealm() })
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                        }
                    }
                    .padding(.top, 16)
                }
                .background(Color("BackgroundColor"))
                .padding(.top, showLogSetView ? -15 : 0)
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
            .onAppear {
                logDataController.weightSelection = "All"
                logDataController.populateListOfWeights(movement.logs)
                logDataController.filterWeightAndPopulateData(movement.logs)
                logDataController.setMostRecentLog(movement.logs)
            }
    }
    
    // MARK: - Functions
    
    private func addLogToRealm() {
        let log = Log(reps: logDataController.reps, weight: logDataController.weight, isBodyWeight: false, repType: .WorkingSet, date: Date().timeIntervalSince1970 + 86400)
        if let thawedMovementLogList = movement.logs.thaw() {
            do {
                try realm.write {
                    thawedMovementLogList.append(log)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        if logDataController.weightSelection != "All" {
                            logDataController.weightSelection = logDataController.weightStr
                            logDataController.setMostRecentLog(movement.logs)
                        }
                        logDataController.populateListOfWeights(movement.logs)
                        logDataController.filterWeightAndPopulateData(movement.logs)
                    }
                }
            } catch  {
                /// Handle error
            }
        }
    }
    
    private func deleteLogInRealm() {
        if let thawedLog = selectedLog.thaw() {
            do {
                try realm.write {
                    realm.delete(thawedLog)
                }
            } catch  {
                /// Handle error
            }
        }
    }

}
