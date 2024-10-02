//
//  SelectedRoutineView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/2/24.
//

import SwiftUI

struct SelectedRoutineView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Public Properties
    
    @StateObject var selectedRoutineViewModel: SelectedRoutineViewModel
    
    // MARK: - Private Properties
    
    @State private var showAddMovmenetsSheet = false
    @State private var showEditRoutinePopup = false
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - View
    
    var body: some View {
        VStack {
            if selectedRoutineViewModel.routine.movementIDs.count == 0 {
                ZStack {
                    Color(theme.backgroundColor).ignoresSafeArea()
                    Text(InfoText.RoutineNoMovements.rawValue)
                        .customFont(size: .body, weight: .semibold, kerning: 0.5, design: .rounded)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(32)
                }
            } else {
                List {
                    ForEach(selectedRoutineViewModel.movements, id: \.id) { movement in
                        RoutineMovementCard(
                            index: (selectedRoutineViewModel.routine.movementIDs.firstIndex(of: movement.id) ?? 0) + 1,
                            movement: movement
                        )
                        .listRowBackground(Color(theme.backgroundColor))
                        .listRowSeparator(.hidden)
                    }
                    .onDelete { offsets in
                        Task {
                            await onDelete(offsets: offsets)
                        }
                    }
                    .onMove { source, destination in
                        Task {
                            await onMove(source: source, destination: destination)
                        }
                    }
                    .padding(.bottom, -8)
                }
                .listStyle(.inset)
                .scrollContentBackground(.hidden)
                .background(Color(theme.backgroundColor))
            }
        }
        .navigationTitle(selectedRoutineViewModel.routine.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .foregroundColor(.primary)
                    .font(.body.weight(.regular))
                    .customFont(weight: .semibold, design: .rounded)
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditRoutineButton(showEditRoutinePopup: $showEditRoutinePopup)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                AddMovementsToolButton(showAddMovmenetsSheet: $showAddMovmenetsSheet)
                    .disabled(selectedRoutineViewModel.routine.movementIDs.count == movementsViewModel.movements.count)
                    .foregroundColor(selectedRoutineViewModel.routine.movementIDs.count == movementsViewModel.movements.count ? .secondary : .primary)
            }
        }
        .sheet(isPresented: $showAddMovmenetsSheet) {
            AddMovementsView(selectedRoutineViewModel: selectedRoutineViewModel)
                .environment(\.sizeCategory, .extraSmall)
                .environment(\.colorScheme, theme.colorScheme)
        }
        .sheet(isPresented: $showEditRoutinePopup) {
            EditRoutineView(routine: selectedRoutineViewModel.routine)
                .environment(\.sizeCategory, .extraSmall)
                .environment(\.colorScheme, theme.colorScheme)
        }
        .onAppear { selectedRoutineViewModel.setMovements(userId: userViewModel.userId, movements: movementsViewModel.movements) }
    }
    
    // MARK: - Function
    
    private func onMove(source: IndexSet, destination: Int) async {
        selectedRoutineViewModel.routine.movementIDs.move(fromOffsets: source, toOffset: destination)
        await selectedRoutineViewModel.updateRoutineMovementsList(userId: userViewModel.userId)
        selectedRoutineViewModel.setMovements(userId: userViewModel.userId, movements: movementsViewModel.movements)
        routinesViewModel.updateRoutineInList(selectedRoutineViewModel.routine)
    }
    
    private func onDelete(offsets: IndexSet) async {
        selectedRoutineViewModel.routine.movementIDs.remove(atOffsets: offsets)
        await selectedRoutineViewModel.updateRoutineMovementsList(userId: userViewModel.userId)
        selectedRoutineViewModel.setMovements(userId: userViewModel.userId, movements: movementsViewModel.movements)
        routinesViewModel.updateRoutineInList(selectedRoutineViewModel.routine)
    }
}
