//
//  LogView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct LogView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Public Properties
    
    var movement: Movement
    @FocusState var isInputActive: Bool
    
    // MARK: - Private Properties
    
    @StateObject private var logViewModel = LogViewModel()
    @State private var selectedLog: Log = Log()
    
    @State private var showEditMovementPopup = false
    @State private var showDoneToolBar = true
    @State private var showLogSetView = true
    @State private var isEditingLogs = false
    
    // MARK: - View
    
    var body: some View {
        VStack {
            if showLogSetView {
                if movement.movementType == .Weight {
                    LogWeightSection(movement: movement,
                                     showDoneToolBar: $showDoneToolBar)
                } else {
                    if let _ = userViewModel.bodyweightEntries.first {
                        LogBodyweightSection(movement: movement)
                    } else {
                        SetBodyweightButtonLink()
                    }
                }
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    LogViewSubHeading(movement: movement)
                    LogListView(movement: movement,
                                isEditingLogs: $isEditingLogs,
                                showLogSetView: $showLogSetView,
                                showDoneToolBar: $showDoneToolBar,
                                selectedLog: $selectedLog)
                }
                .padding(.top, movement.movementType == .Weight && logsViewModel.listOfWeights.count >= 3 ? 16 : 0)
            }
            .background(Color(theme.backgroundColor))
            .padding(.top, showLogSetView ? -8 : 0)
            .sheet(isPresented: $showEditMovementPopup) {
                EditMovementView(movementViewModel: MovementViewModel(movement: movement),
                                 showDoneToolBar: $showDoneToolBar)
                    .environment(\.sizeCategory, .extraSmall)
                    .environment(\.colorScheme, theme.colorScheme)
            }
        }
        .environmentObject(logViewModel)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditMovementButton(showEditMovementPopup: $showEditMovementPopup,
                                   showDoneToolBar: $showDoneToolBar)
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
        .onAppear { setLogsOnAppear() }
    }
    
    // MARK: - Functions
    
    private func setLogsOnAppear() {
        logsViewModel.repopulateViewModel(weightSelection: WeightSelection.All.rawValue,
                                          movement: movement)
        logViewModel.setLastLog(logsViewModel.filteredLogs,
                                weightSelection: logsViewModel.weightSelection,
                                isBodyweight: movement.movementType == .Bodyweight ? true : false)
    }
}
