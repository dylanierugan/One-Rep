//
//  EditRoutineView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/7/24.
//

import SwiftUI

struct EditRoutineView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    
    // MARK: - Public Properties
    
    @ObservedObject var routineViewModel = RoutineViewModel()
    
    // MARK: - Private Properties
    
    @State private var newRoutineName = ""
    @State private var newIcon = ""
    @State private var showEditProgressView = false
    @State private var deleteConfirmedClicked = false
    @State private var showingDeleteRoutineAlert = false
    @State private var showDeleteProgressView = false
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                
                VStack(spacing: 36) {
                    Text(EditRoutineStrings.EditRoutine.rawValue)
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    
                    /// Textfield
                    VStack(alignment: .leading, spacing: 6) {
                        Text(EditRoutineStrings.EditName.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        RoutineNameTextfield(focus: false, routineName: $newRoutineName, text: "")
                    }
                    
                    /// Icon Picker
                    VStack(alignment: .leading, spacing: 6) {
                        Text(AddRoutineStrings.RoutineIcon.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        HStack {
                            RoutineIconPicker(selectedIcon: $newIcon)
                        }
                    }
                    
                }
                .padding(.horizontal, 16)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        DeleteRoutineButton(deleteConfirmedClicked: $deleteConfirmedClicked, showingDeleteRoutineAlert: $showingDeleteRoutineAlert, deleteRoutineInFirebase: {
                            deleteRoutine()
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        if showEditProgressView {
                            ProgressView()
                        } else {
                            UpdateRoutineButton(updateRoutineInFirebase: {
                                editRoutine()
                            })
                        }
                    }
                })
            }
            .onAppear { setValues() }
        }
    }
    
    // MARK: - View
    
    private func setValues() {
        newRoutineName = routineViewModel.routine.name
        newIcon = routineViewModel.routine.icon
    }
    
    private func editRoutine() {
        Task {
            showEditProgressView = true
            routineViewModel.routine.name = newRoutineName
            routineViewModel.routine.icon = newIcon
            let result = await routineViewModel.updateRoutine()
            ResultHandler.shared.handleResult(result: result, onSuccess: {
                dismiss()
            }) // Todo - Handle error
        }
    }
    
    private func deleteRoutine() {
        Task {
            showDeleteProgressView = true
            let result = await routinesViewModel.deleteRoutine(routineViewModel.routine)
            ResultHandler.shared.handleResult(result: result, onSuccess: {
                dismiss()
            }) // Todo - Handle error
        }
    }
    
}
