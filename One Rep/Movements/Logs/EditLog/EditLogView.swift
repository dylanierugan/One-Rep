//
//  EditLogView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/22/24.
//

import SwiftUI

struct EditLogView: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var logController: LogController
    
    @Binding var log: Log
    @State var movement: Movement
    @State var isDeletingLog = false
    @State var isUpdatingLog = false
    
    @State private var date = Date()
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                
                VStack(spacing: 64) {
                    
                    Text("Edit Log")
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                        .padding(.top, 32)
                    
                    VStack(spacing: 32) {
                        HStack(spacing: 16) {
                            VStack(alignment: .center, spacing: 4) {
                                Text("Edit weight")
                                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                                    .foregroundColor(.secondary)
                                EditWeightTextField(log: log, movement: movement, isInputActive: _isInputActive)
                            }
                            VStack(alignment: .center, spacing: 4) {
                                Text("Edit reps")
                                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                                    .foregroundColor(.secondary)
                                EditRepsTextField(log: log, isInputActive: _isInputActive)
                            }
                        }
                        DatePicker("Date/Time", selection: $date)
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
                                Text("Done")
                                    .foregroundStyle(.primary)
                                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        //DeleteLogButton(deleteLogInRealm: { self.deleteLogInRealm() })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if isUpdatingLog {
                            ProgressView()
                        } else {
                            UpdateLogButton(updateLogInFirebase: {
                                Task {
                                    isUpdatingLog = true
                                    log.weight = logController.editWeight
                                    log.reps = logController.editReps
                                    log.timeAdded = date.timeIntervalSince1970
                                    let result = await logViewModel.updateLog(log: log)
                                    handleEditLog(result: result, errorMessage: "")
                                    isUpdatingLog = false
                                }
                            })
                        }
                    }
                }
            }
            .onAppear {
                date = Date(timeIntervalSince1970: log.timeAdded)
                logController.editWeight = log.weight
                logController.editWeightStr = log.weight.clean
                logController.editReps = log.reps
                logController.editRepsStr = String(log.reps)
            }
        }
    }
    
    func handleEditLog(result: FirebaseResult?, errorMessage: String) {
        guard let result = result else { return }
        switch result {
        case .success:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if logViewModel.weightSelection == "All" {
                    logViewModel.repopulateViewModel(weightSelection: "All", movement: movement)
                } else {
                    logViewModel.repopulateViewModel(weightSelection: logController.editWeightStr, movement: movement)
                }
                logController.setMostRecentLog(logViewModel.filteredLogs, weightSelection: logViewModel.weightSelection)
                dismiss()
            }
            return
        case .failure(_):
            print(errorMessage)
        }
    }
}
