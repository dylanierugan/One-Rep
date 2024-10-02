//
//  EditRoutineView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/7/24.
//

import SwiftUI

struct EditRoutineView: View {
    
    init(routine: Routine) {
        self.routine = routine
        _editRoutineViewModel = StateObject(wrappedValue: EditRoutineViewModel(routine: routine))
    }
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Private Properties
    
    var routine: Routine
    @StateObject private var editRoutineViewModel: EditRoutineViewModel
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
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(EditRoutineStrings.EditName.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        RoutineNameTextfield(focus: false, routineName: $editRoutineViewModel.name, text: "")
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(AddRoutineStrings.RoutineIcon.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        HStack {
                            RoutineIconPicker(selectedIcon: $editRoutineViewModel.icon)
                        }
                    }
                    
                }
                .padding(.horizontal, 16)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        DeleteRoutineButton(deleteConfirmedClicked: $editRoutineViewModel.deleteConfirmedClicked, showingDeleteRoutineAlert: $editRoutineViewModel.showingDeleteRoutineAlert, deleteRoutineInFirebase: {
                            Task {
                                await deleteRoutine()
                            }
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        if editRoutineViewModel.showEditingRoutineProgressView {
                            ProgressView()
                        } else {
                            UpdateRoutineButton(updateRoutineInFirebase: {
                                Task {
                                    await editRoutine()
                                }
                            })
                        }
                    }
                })
            }
            .onAppear { editRoutineViewModel.setEditableAttributes() }
        }
    }
    
    // MARK: - View
    
    private func editRoutine() async {
        await editRoutineViewModel.updateRoutineAttributes(userId: userViewModel.userId)
        routinesViewModel.updateRoutineInList(editRoutineViewModel.routine)
        dismiss()
    }
    
    private func deleteRoutine() async {
        await editRoutineViewModel.deleteRoutine(userId: userViewModel.userId)
        routinesViewModel.deleteRoutineInList(editRoutineViewModel.routine)
        dismiss()
    }
}
