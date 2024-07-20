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
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var logController: LogController
    @EnvironmentObject var errorHandler: ErrorHandler
    
    // MARK: - Public Properties
    
    @Binding var log: Log
    @State var movement: Movement
    @FocusState var isInputActive: Bool
    
    // MARK: - Private Properties

    @State private var isDeletingLog = false
    @State private var isUpdatingLog = false
    @State private var date = Date()
    
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
                        HStack(spacing: 16) {
                            VStack(alignment: .center, spacing: 4) {
                                Text(EditLogStrings.EditWeight.rawValue)
                                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                                    .foregroundColor(.secondary)
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
    }
    
    // MARK: - Functions
    
    private func setLogControllerOnAppear() {
        date = Date(timeIntervalSince1970: log.timeAdded)
        logController.editWeight = log.weight
        logController.editWeightStr = log.weight.clean
        logController.editReps = log.reps
        logController.editRepsStr = String(log.reps)
    }
    
    private func updateLog() {
        Task {
            isUpdatingLog = true
            log.weight = logController.editWeight
            log.reps = logController.editReps
            log.timeAdded = date.timeIntervalSince1970
            let result = await logViewModel.updateLog(log: log)
            errorHandler.handleUpdateLog(result: result, logViewModel: logViewModel, logController: logController, movement: movement)
            dismiss()
        }
    }
    
    private func deleteLog() {
        Task {
            isDeletingLog = true
            let result = await logViewModel.deleteLog(docId: log.id)
            errorHandler.handleDeleteLog(result: result, logViewModel: logViewModel, logController: logController, movement: movement)
        }
    }
}
