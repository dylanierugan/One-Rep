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
    @EnvironmentObject var errorHandler: ErrorHandler
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Public Properties
    
    @ObservedObject var routineViewModel = RoutineViewModel()
    
    // MARK: - Private Properties
    
    @State private var movementIDdict = [String : Movement]()
    @State private var showAddMovmenetsSheet = false
    
    private let defaultMovement = Movement(id: "",
                                           userId: "",
                                           name: "Error loading Movement",
                                           muscleGroup: .All,
                                           movementType: .Bodyweight,
                                           timeAdded: 0,
                                           isPremium: false,
                                           mutatingValue: 0)
    
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
                        ForEach(routineViewModel.routine.movementIDs, id: \.self) { movementID in
                            RoutineMovementCard(
                                index: (routineViewModel.routine.movementIDs.firstIndex(of: movementID) ?? 0) + 1,
                                movement: movementIDdict[movementID] ?? defaultMovement
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
                        .foregroundColor(colorScheme == .dark ? Color(theme.lightBaseColor) : Color(theme.darkBaseColor))
                        .font(.body.weight(.regular))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    AddMovementsToolButton(showAddMovmenetsSheet: $showAddMovmenetsSheet)
                        .disabled(routineViewModel.routine.movementIDs.count == movementsViewModel.movements.count)
                        .foregroundColor(routineViewModel.routine.movementIDs.count == movementsViewModel.movements.count ? .secondary :
                            (colorScheme == .dark ? Color(theme.lightBaseColor) : Color(theme.darkBaseColor)))
                }
            }
            .sheet(isPresented: $showAddMovmenetsSheet) {
                AddMovementsView(routineViewModel: routineViewModel)
                    .environment(\.sizeCategory, .extraSmall)
                    .environment(\.colorScheme, theme.colorScheme)
            }
            .onAppear { setMovements() }
    }
    
    // MARK: - Function
    
    private func setMovements() {
        for movement in movementsViewModel.movements {
            movementIDdict[movement.id] = movement
        }
    }
    
    private func onDelete(offsets: IndexSet) async {
        DispatchQueue.main.async {
            routineViewModel.routine.movementIDs.remove(atOffsets: offsets)
        }
        Task {
            let result = await routineViewModel.updateRoutine()
            errorHandler.handleUpdateRoutine(result: result)
        }
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        DispatchQueue.main.async {
            routineViewModel.routine.movementIDs.move(fromOffsets: source, toOffset: destination)
        }
        Task {
            let result = await routineViewModel.updateRoutine()
            errorHandler.handleUpdateRoutine(result: result)
        }
    }
}
