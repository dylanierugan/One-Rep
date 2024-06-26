//
//  MovementSetView.swift
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
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var logController: LogController
    
    @ObservedRealmObject var movementViewModel: MovementViewModel
    @ObservedRealmObject var movement: Movement
    @ObservedRealmObject var userModel: UserModel
    @State var selectedLog: Log = Log()
    
    @State private var showEditMovementPopup = false
    @State private var addWeightToBodyweight = false
    @State private var showDoneToolBar = true
    @State private var showLogSetView = true
    @State private var isEditingLogs = false
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack {
            if showLogSetView {
                if movement.movementType == .Weight {
                    LogWeightSection(movement: movement, showDoneToolBar: $showDoneToolBar, addLogToRealm: addLogToRealm)
                } else {
                    if let _ = userModel.bodyweightEntries.last {
                        LogBodyweightSection(userModel: userModel, movement: movement, addWeightToBodyWeight: $addWeightToBodyweight, addLogToRealm: addLogToRealm)
                            .padding(.top, -16)
                    } else {
                        SetBodyweightButton(userModel: userModel)
                    }
                }
            }
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 16) {
                    if movement.logs.count != 0 {
                        if movement.movementType != .Bodyweight {
                            WeightHorizontalScroller(movement: movement)
                        }
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
                    
                    ForEach(0..<logViewModel.listOfDates.count, id: \.self) { index in
                        let date = logViewModel.listOfDates[index]
                        Section(header: HStack {
                            Text(date)
                                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                                .foregroundColor(.primary)
                            Spacer()
                            if index == 0 {
                                ToggleEditLogButton(isEditingLogs: $isEditingLogs)
                                    .padding(.horizontal, 8)
                                ShowFullScreenButton(showLogSetView: $showLogSetView)
                            }
                        }
                            .padding(.horizontal, 20)
                        ){
                            VStack {
                                if let logs = logViewModel.dateLogMap[date] {
                                    ForEach(logs.indices, id: \.self) { index in
                                        let reverseIndex = logs.count - 1 - index
                                        let log = logs[reverseIndex]
                                        HStack {
                                            LogCard(log: log, movement: movement, index: index ,showDoneToolBar: $showDoneToolBar)
                                            if isEditingLogs {
                                                DeleteLogTrashIconButton(movement: movement,
                                                                         log: log,
                                                                         selectedLog: $selectedLog,
                                                                         deleteLogInRealm: { self.deleteLogInRealm() })
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color(theme.backgroundElementColor))
                            .cornerRadius(16)
                            .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.top, 16)
            }
            .background(Color(theme.backgroundColor))
            .padding(.top, showLogSetView ? -15 : 0)
        }
        .sheet(isPresented: $showEditMovementPopup) {
            EditMovementView(movement: movement, movementViewModel: movementViewModel, showDoneToolBar: $showDoneToolBar)
                .environment(\.sizeCategory, .extraSmall)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditMovementButton(showEditMovementPopup: $showEditMovementPopup, showDoneToolBar: $showDoneToolBar)
                
            }
            ToolbarItem(placement: .principal) {
                HStack(spacing: 12) {
                    Image(movement.muscleGroup.rawValue.lowercased())
                        .font(.caption2)
                        .foregroundStyle(.linearGradient(colors: [
                            Color(theme.lightBaseColor),
                            Color(theme.darkBaseColor)
                        ], startPoint: .top, endPoint: .bottom))
                    Text(movement.name)
                        .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            logViewModel.weightSelection = "All"
            logViewModel.populateListOfWeights(movement.logs)
            logViewModel.filterWeightAndPopulateData(movement.logs)
            logController.setMostRecentLog(movement.logs, weightSelection: logViewModel.weightSelection)
        }
    }
    
    // MARK: - Functions
    
    private func addLogToRealm() {
        
        var loggedWeight: Double = 0
        var isBodyWeight = false
        
        if movement.movementType == .Weight {
            loggedWeight = logController.weight
        } else {
            if let bodyweightEntry = userModel.bodyweightEntries.last {
                loggedWeight = bodyweightEntry.bodyweight
            }
        }
        
        if movement.movementType == .Bodyweight && addWeightToBodyweight {
            loggedWeight += logController.weight
            isBodyWeight = true
        }
        
        let log = Log(reps: logController.reps, weight: loggedWeight, isBodyWeight: isBodyWeight, repType: .WorkingSet, date: Date().timeIntervalSince1970, movement: nil)
        let managedMovement: Movement
        if let existingMovement = realm.object(ofType: Movement.self, forPrimaryKey: movement._id) {
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
                        if logViewModel.weightSelection != "All" {
                            logViewModel.weightSelection = logController.weightStr
                            logController.setMostRecentLog(movement.logs, weightSelection: logViewModel.weightSelection)
                        }
                        logViewModel.populateListOfWeights(movement.logs)
                        logViewModel.filterWeightAndPopulateData(movement.logs)
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
