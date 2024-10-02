//
//  EditRoutineViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/29/24.
//

import Foundation

@MainActor
class EditRoutineViewModel: ObservableObject {
    
    init(routine: Routine) {
        self.routine = routine
    }
    
    // MARK: - Properties
    
    @Published var routine: Routine
    
    @Published var name = ""
    @Published var icon = ""
    
    @Published var showEditingRoutineProgressView = false
    @Published var showDeletingRoutineProgressView = false
    @Published var deleteConfirmedClicked = false
    @Published var showingDeleteRoutineAlert = false
    
    // MARK: - Functions
    
    func setEditableAttributes() {
        name = routine.name
        icon = routine.icon
    }
    
    func setNewRoutineAttributes() {
        routine.name = name
        routine.icon = icon
    }
    
    func updateRoutineAttributes(userId: String) async {
        setNewRoutineAttributes()
        showEditingRoutineProgressView = true
        defer { showEditingRoutineProgressView = false }
        do {
            try await RoutineNetworkManager.shared.updateRoutineAttributes(userId: userId, routine: routine)
        } catch {
            // TODO: Handle error
        }
    }
    
    func deleteRoutine(userId: String) async {
        showDeletingRoutineProgressView = true
        defer { showDeletingRoutineProgressView = false }
        do {
            try await RoutineNetworkManager.shared.deleteRoutine(userId: userId, routine: routine)
        } catch {
            // TODO: Handle error
        }
    }
}
