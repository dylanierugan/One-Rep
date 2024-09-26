//
//  SelectedMovementView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct SelectedMovementView: View {
    
    init(movement: Movement) {
        self.movement = movement
        _selectedMovementViewModel = StateObject(wrappedValue: SelectedMovementViewModel(movement: movement))
    }
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Public Properties
    
    var movement: Movement
    @FocusState var isInputActive: Bool
    
    // MARK: - Private Properties
    
    @StateObject private var selectedMovementViewModel: SelectedMovementViewModel
    @StateObject private var logViewModel: LogViewModel = LogViewModel()
    @StateObject private var editLogViewModel = EditLogViewModel(log: Log())
    
    @State private var selectedLog: Log = Log()
    
    // MARK: - View
    
    var body: some View {
        VStack {
            if selectedMovementViewModel.showLogSetView {
                if movement.movementType == .Weight {
                    LogWeightSection(movement: movement,
                                     showDoneToolBar: $selectedMovementViewModel.showDoneToolBar)
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
                                logsViewModel: logsViewModel, 
                                isEditingLogs: $selectedMovementViewModel.isEditingLogs,
                                showLogSetView: $selectedMovementViewModel.showLogSetView,
                                showDoneToolBar: $selectedMovementViewModel.showDoneToolBar,
                                selectedLog: $selectedLog)
                }
                // .padding(.top, movement.movementType == .Weight && logsViewModel.listOfWeights.count >= 3 ? 3 : 0)
            }
            .background(Color(theme.backgroundColor))
            .padding(.top, selectedMovementViewModel.showLogSetView ? -8 : 0)
            .sheet(isPresented: $selectedMovementViewModel.showEditMovementPopup) {
                EditMovementView(movement: movement,
                                 showDoneToolBar: $selectedMovementViewModel.showDoneToolBar)
                .environment(\.sizeCategory, .extraSmall)
                .environment(\.colorScheme, theme.colorScheme)
            }
        }
        .environmentObject(selectedMovementViewModel)
        .environmentObject(logViewModel)
        .environmentObject(editLogViewModel)
        .toolbar {
            ToolbarItem(placement: .principal) {
                EditMovementButton(movement: movement,
                                   showEditMovementPopup: $selectedMovementViewModel.showEditMovementPopup,
                                   showDoneToolBar: $selectedMovementViewModel.showDoneToolBar)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            setLogs()
        }
    }
    
    // MARK: - Functions
    
    private func setLogs() {
        logsViewModel.repopulateViewModel(movement: movement)
        logViewModel.setLastLog(logsViewModel.filteredLogs,
                                isBodyweight: movement.movementType == .Bodyweight ? true : false)
    }
}
