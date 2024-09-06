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
    
    // MARK: - Public Properties
    
    @StateObject var routineViewModel = RoutineViewModel()
    
    // MARK: - Private Properties
    
    @State private var showAddMovmenetsSheet = false
    @State private var showEditRoutinePopup = false
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - View
    
    var body: some View {
        VStack {
            if routineViewModel.routine.movementIDs.count == 0 {
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
                    ForEach(routineViewModel.movements, id: \.id) { movement in
                        RoutineMovementCard(
                            index: (routineViewModel.routine.movementIDs.firstIndex(of: movement.id) ?? 0) + 1,
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
                    .onMove(perform: onMove)
                    .padding(.bottom, -8)
                }
                .listStyle(.inset)
                .scrollContentBackground(.hidden)
                .background(Color(theme.backgroundColor))
            }
        }
        .navigationTitle(routineViewModel.routine.name)
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
                    .disabled(routineViewModel.routine.movementIDs.count == movementsViewModel.movements.count)
                    .foregroundColor(routineViewModel.routine.movementIDs.count == movementsViewModel.movements.count ? .secondary : .primary)
            }
        }
        .sheet(isPresented: $showAddMovmenetsSheet) {
            AddMovementsView(routineViewModel: routineViewModel)
                .environment(\.sizeCategory, .extraSmall)
                .environment(\.colorScheme, theme.colorScheme)
        }
        .sheet(isPresented: $showEditRoutinePopup) {
            EditRoutineView(routineViewModel: routineViewModel)
                .environment(\.sizeCategory, .extraSmall)
                .environment(\.colorScheme, theme.colorScheme)
        }
        .onAppear { routineViewModel.setMovements(movements: movementsViewModel.movements) }
    }
    
    // MARK: - Function
    
    private func onDelete(offsets: IndexSet) async {
        routineViewModel.routine.movementIDs.remove(atOffsets: offsets)
        Task {
            let result = await routineViewModel.updateRoutine()
            await MainActor.run {
                ResultHandler.shared.handleResult(result: result, onSuccess: {
                    routineViewModel.setMovements(movements: movementsViewModel.movements)
                })
            } // Todo - Error handle
        }
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        routineViewModel.routine.movementIDs.move(fromOffsets: source, toOffset: destination)
        Task {
            let result = await routineViewModel.updateRoutine()
            await MainActor.run {
                ResultHandler.shared.handleResult(result: result, onSuccess: {
                    routineViewModel.setMovements(movements: movementsViewModel.movements)
                })
            }
        }
    }
}
