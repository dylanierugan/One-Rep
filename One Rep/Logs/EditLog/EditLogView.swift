//
//  EditLogView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/22/24.
//

import SwiftUI

struct EditLogView: View {
    
    // MARK: - Global Properties
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var errorHandler: ErrorHandler
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Public Properties
    
    @Binding var log: Log
    @State var movement: Movement
    @FocusState var isInputActive: Bool
    
    // MARK: - Private Properties

    @StateObject private var editLogViewModel: EditLogViewModel
    @State private var isDeletingLog = false
    @State private var isUpdatingLog = false
    @State private var date = Date()
    
    // MARK: - Init
    
    init(log: Binding<Log>, movement: Movement, logViewModel: LogViewModel) {
        self._log = log
        self._movement = State(initialValue: movement)
        self._editLogViewModel = StateObject(wrappedValue: EditLogViewModel(lastLog: log.wrappedValue))
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
                        DatePicker(EditLogStrings.DateTime.rawValue, selection: $date)
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
                        if isDeletingLog {
                            ProgressView()
                        } else {
                            DeleteLogButton() {
                                deleteLog()
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if isUpdatingLog {
                            ProgressView()
                        } else {
                            UpdateLogButton(updateLogInFirebase: {
                                updateLog()
                            })
                        }
                    }
                }
            }
            .onAppear {
                setLogControllerOnAppear()
            }
        }
        .environmentObject(editLogViewModel)
    }
    
    // MARK: - Functions
    
    private func setLogControllerOnAppear() {
        date = Date(timeIntervalSince1970: log.timeAdded)
        editLogViewModel.editWeight = log.weight
        editLogViewModel.editWeightStr = log.weight.clean
        editLogViewModel.editReps = log.reps
        editLogViewModel.editRepsStr = String(log.reps)
        if let bodyweightEntry = userViewModel.bodyweightEntries.first {
            editLogViewModel.editBodyweight = bodyweightEntry.bodyweight
        }
    }
    
    private func updateLog() {
        Task {
            isUpdatingLog = true
            log.weight = editLogViewModel.editWeight
            log.reps = editLogViewModel.editReps
            log.bodyweight = editLogViewModel.editBodyweight
            log.timeAdded = date.timeIntervalSince1970
            let result = await logsViewModel.updateLog(log: log)
            errorHandler.handleUpdateLog(result: result, logsViewModel: logsViewModel, logViewModel: logViewModel, editLogViewModel: editLogViewModel, movement: movement)
            dismiss()
        }
    }
    
    private func deleteLog() {
        Task {
            isDeletingLog = true
            let result = await logsViewModel.deleteLog(docId: log.id)
            errorHandler.handleDeleteLog(result: result, logsViewModel: logsViewModel, logViewModel: logViewModel, movement: movement)
        }
    }
}
