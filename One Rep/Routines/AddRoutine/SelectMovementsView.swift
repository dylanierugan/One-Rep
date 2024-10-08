//
//  SelectMovementsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/23/24.
//

import SwiftUI

struct SelectMovementsView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Public Properties
    
    @ObservedObject var addRoutineViewModel: AddRoutineViewModel
    
    // MARK: - Private Properties
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            ScrollView {
                Text(InfoText.ChooseMovements.rawValue)
                    .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                VStack(spacing: 16) {
                    ForEach(MuscleGroup.allCases, id: \.rawValue) { muscle in
                        VStack(spacing: 16) {
                            if addRoutineViewModel.muscleGroupMovementDict[muscle.rawValue]?.count ?? 0 > 0 {
                                if muscle != .All {
                                    HStack {
                                        Text(muscle.rawValue)
                                            .customFont(size: .title2, weight: .bold, kerning: 0, design: .rounded)
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                }
                                if let movements = addRoutineViewModel.muscleGroupMovementDict[muscle.rawValue]?.sorted(by: { $0.name < $1.name }) {
                                    ForEach(movements, id: \.id) { movement in
                                        HStack(spacing: 16) {
                                            
                                            Button {
                                                withAnimation {
                                                    if addRoutineViewModel.selectedMovments.contains(where: { ($0.id == movement.id) }) {
                                                        if let index = addRoutineViewModel.selectedMovments.firstIndex(of: movement) {
                                                            addRoutineViewModel.selectedMovments.remove(at: index)
                                                        }
                                                    } else {
                                                        addRoutineViewModel.selectedMovments.append(movement)
                                                    }
                                                    HapticManager.instance.impact(style: .soft)
                                                }
                                            } label: {
                                                if addRoutineViewModel.selectedMovments.contains(movement) {
                                                    ZStack {
                                                        Image(systemName: Icons.Checkmark.rawValue)
                                                            .foregroundStyle(Color(.black))
                                                            .font(.caption)
                                                            .bold()
                                                            .zIndex(1)
                                                        Circle()
                                                            .frame(width: 24, height: 24)
                                                            .foregroundStyle(colorScheme == .dark ? Color(theme.lightBaseColor) :  Color(theme.darkBaseColor))
                                                    }
                                                } else {
                                                    ZStack {
                                                        Image(systemName: Icons.Plus.rawValue)
                                                            .foregroundStyle(colorScheme == .dark ? Color(theme.lightBaseColor) :  Color(theme.darkBaseColor))
                                                            .font(.caption)
                                                            .bold()
                                                        Circle()
                                                            .frame(width: 24, height: 24)
                                                            .foregroundStyle(colorScheme == .dark ? Color(theme.lightBaseColor).opacity(0.2) :  Color(theme.darkBaseColor).opacity(0.2))
                                                    }
                                                }
                                            }
                                            Text(movement.name)
                                                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 32)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if addRoutineViewModel.showSecondAddingRoutineProgressView {
                    ProgressView()
                } else {
                    AddRoutineButton(isFormValid: addRoutineViewModel.isFormSelectedMovementsValid,
                                     addRoutineToFirebase: {
                        Task {
                            await addRoutine()
                        }
                    })
                }
            }
        }
        .onAppear { populateMuscleMovementDictionary() }
    }
    
    // MARK: - Functions
    
    private func populateMuscleMovementDictionary() {
        for muscle in MuscleGroup.allCases {
            addRoutineViewModel.muscleGroupMovementDict[muscle.rawValue] = []
        }
        for movement in movementsViewModel.movements {
            addRoutineViewModel.muscleGroupMovementDict[movement.muscleGroup.rawValue]?.append(movement)
        }
    }
    
    private func addRoutine() async {
        let newRoutine = await addRoutineViewModel.addRoutine(userId: userViewModel.userId, addRoutineViewModel: addRoutineViewModel)
        guard let newRoutine = newRoutine else { return }
        routinesViewModel.routines.append(newRoutine)
        addRoutineViewModel.dismissBothViews = true
        dismiss()
    }
}
