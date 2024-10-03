//
//  EditLogView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/22/24.
//

import SwiftUI

struct EditLogView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var editLogViewModel: EditLogViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Public Properties
    
    var log: Log
    var movement: Movement
    @FocusState var isInputActive: Bool
    
    // MARK: - Private Properties
    
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Init
    
    init(log: Log,
         movement: Movement,
         logViewModel: LogViewModel) {
        self.log = log
        self.movement = movement
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                VStack(spacing: 64) {
                    Text(EditLogStrings.EditLog.rawValue)
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                        .padding(.top, 32)
                    VStack(spacing: 32) {
                        if movement.movementType == .Bodyweight {
                            VStack(alignment: .center, spacing: 4) {
                                Text(EditLogStrings.EditBodyweight.rawValue)
                                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                                    .foregroundColor(.secondary)
                                EditBodyweightTextField()
                            }
                        }
                        HStack(spacing: 16) {
                            VStack(alignment: .center, spacing: 4) {
                                if movement.movementType == .Bodyweight {
                                    Text(EditLogStrings.EditAddedWeight.rawValue)
                                        .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                                        .foregroundColor(.secondary)
                                } else {
                                    Text(EditLogStrings.EditWeight.rawValue)
                                        .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                                        .foregroundColor(.secondary)
                                }
                                EditWeightTextField(log: log, movement: movement, isInputActive: _isInputActive)
                            }
                            VStack(alignment: .center, spacing: 4) {
                                Text(EditLogStrings.EditReps.rawValue)
                                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                                    .foregroundColor(.secondary)
                                EditRepsTextField(log: log, isInputActive: _isInputActive)
                            }
                        }
                        DatePicker(EditLogStrings.DateTime.rawValue, selection: $editLogViewModel.date)
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            .datePickerStyle(.automatic)
                            .padding(.horizontal)
                            .accentColor(colorScheme == .dark ? Color(theme.lightBaseColor) : Color(theme.darkBaseColor))
                    }
                    Spacer()
                }
                .padding(.top, 64)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button {
                                isInputActive = false
                            } label: {
                                Text(EditLogStrings.Done.rawValue)
                                    .foregroundStyle(.primary)
                                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        if editLogViewModel.isDeletingLog {
                            ProgressView()
                        } else {
                            DeleteLogButton() {
                                Task {
                                    await deleteLog()
                                }
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if editLogViewModel.isUpdatingLog {
                            ProgressView()
                        } else {
                            UpdateLogButton(updateLogInFirebase: {
                                Task {
                                    await updateLog()
                                }
                            })
                        }
                    }
                }
            }
            .onAppear {
                editLogViewModel.log = log
                editLogViewModel.setEditingValues(userViewModel: userViewModel)
            }
        }
    }
    
    // MARK: - Functions
    
    private func updateLog() async {
        await editLogViewModel.updateLog(userId: userViewModel.userId,
                                   movement: movement) // TODO: Error handle
        logsViewModel.updateLogInLocalList(editLogViewModel.log)
        updateLogViewModel()
        dismiss()
    }
    
    private func updateLogViewModel() {
        logsViewModel.repopulateViewModel(movement: movement)
        logViewModel.setLastLog(logsViewModel.filteredLogs,
                                isBodyweight: movement.movementType == .Bodyweight ? true : false)
    }
    
    private func deleteLog() async {
        await editLogViewModel.deleteLog(userId: userViewModel.userId,
                                         movement: movement)
        logsViewModel.deleteLogInLocalList(editLogViewModel.log)
        deleteLogViewModel()
        dismiss()
    }
    
    private func deleteLogViewModel() {
        logsViewModel.repopulateViewModel(movement: movement)
        logViewModel.setLastLog(logsViewModel.filteredLogs,
                                isBodyweight: movement.movementType == .Bodyweight ? true : false)
    }
}
