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
    @EnvironmentObject var logDataViewModel: LogDataViewModel
    
    @ObservedRealmObject var movementViewModel: MovementViewModel
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
                            MutateWeightView(isInputActive: _isInputActive, movement: movement)
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
                                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.secondary)
                                    .padding(.top, 36)
                                Spacer()
                            }
                        }
                        
                        ForEach(0..<logDataViewModel.listOfDates.count, id: \.self) { index in
                            let date = logDataViewModel.listOfDates[index]
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
                                ForEach(logDataViewModel.dateLogMap[date] ?? [], id: \.id) { log in
                                    let weightStr = logDataViewModel.convertWeightDoubleToString(log.weight)
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
                EditMovementView(movement: movement, movementViewModel: movementViewModel, showDoneToolBar: $showDoneToolBar)
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
                logDataViewModel.weightSelection = "All"
                logDataViewModel.populateListOfWeights(movement.logs)
                logDataViewModel.filterWeightAndPopulateData(movement.logs)
                logDataViewModel.setMostRecentLog(movement.logs)
            }
    }
    
    // MARK: - Functions
    
    private func addLogToRealm() {
        /// Ensure movement is managed by the same Realm instance
        let log = Log(reps: logDataViewModel.reps, weight: logDataViewModel.weight, isBodyWeight: false, repType: .WorkingSet, date: Date().timeIntervalSince1970, movement: nil)
        let managedMovement: Movement
        if let existingMovement = realm.object(ofType: Movement.self, forPrimaryKey: movement.id) {
            managedMovement = existingMovement
        } else {
            try! realm.write {
                realm.add(movement, update: .all)
            }
            managedMovement = movement
        }
        log.movement = managedMovement
        if let thawedMovementLogList = movement.logs.thaw() {
            do {
                try realm.write {
                    thawedMovementLogList.append(log)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        if logDataViewModel.weightSelection != "All" {
                            logDataViewModel.weightSelection = logDataViewModel.weightStr
                            logDataViewModel.setMostRecentLog(movement.logs)
                        }
                        logDataViewModel.populateListOfWeights(movement.logs)
                        logDataViewModel.filterWeightAndPopulateData(movement.logs)
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
