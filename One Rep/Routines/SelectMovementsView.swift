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
    @EnvironmentObject var errorHandler: ErrorHandler
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Public Properties
    
    @Binding var routineName: String
    @Binding var selectedIcon: String
    @Binding var dismissBothViews: Bool
    
    // MARK: - Private Properties
    
    @State private var muscleGroupMovementDict: [String: [Movement]] = [:]
    @State private var showProgressView = false
    @State private var selectedMovments = [Movement]()
    @State private var selectedMovmentsIDs = [String]()
    
    private var isFormValid: Bool {
        selectedMovments.count != 0
    }
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            ScrollView {
                Text(InfoText.ChooseMovements.rawValue)
                    .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
                    .multilineTextAlignment(.center)
                VStack(spacing: 16) {
                    ForEach(MuscleGroup.allCases, id: \.rawValue) { muscle in
                        VStack(spacing: 16) {
                            if muscleGroupMovementDict[muscle.rawValue]?.count ?? 0 > 0 {
                                if muscle != .All {
                                    HStack {
                                        Text(muscle.rawValue)
                                            .customFont(size: .title2, weight: .bold, kerning: 0, design: .rounded)
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                }
                                if let movements = muscleGroupMovementDict[muscle.rawValue] {
                                    ForEach(movements, id: \.id) { movement in
                                        HStack {
                                            Button {
                                                if selectedMovments.contains(where: { ($0.id == movement.id) }) {
                                                    if let index = selectedMovments.firstIndex(of: movement) {
                                                        selectedMovments.remove(at: index)
                                                    }
                                                } else {
                                                    selectedMovments.append(movement)
                                                }
                                            } label: {
                                                HStack {
                                                    Text(movement.name)
                                                }
                                                .padding(.vertical, 8)
                                                .padding(.horizontal, 12)
                                                .foregroundColor(selectedMovments.contains(movement) ? (colorScheme == .dark ? Color(theme.lightBaseColor) :  Color(theme.darkBaseColor)) : (colorScheme == .dark ? Color(theme.lightBaseColor) :  Color(theme.darkBaseColor)).opacity(0.5))
                                                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                                                .background(.ultraThickMaterial)
                                                .cornerRadius(12)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(selectedMovments.contains(movement) ? (colorScheme == .dark ? Color(theme.lightBaseColor) :  Color(theme.darkBaseColor)) : (colorScheme == .dark ? Color(theme.lightBaseColor) :  Color(theme.darkBaseColor)).opacity(0.5), lineWidth: 4)
                                                )
                                                .cornerRadius(12)
                                            }
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
                if showProgressView {
                    ProgressView()
                } else {
                    AddRoutineButton(isFormValid: isFormValid, addRoutineToFirebase: addRoutine)
                }
            }
        }
        .onAppear {populateMuscleMovementDictionary()}
    }
    
    // MARK: - Functions
    
    private func populateMuscleMovementDictionary() {
        for muscle in MuscleGroup.allCases {
            muscleGroupMovementDict[muscle.rawValue] = []
        }
        for movement in movementsViewModel.movements {
            muscleGroupMovementDict[movement.muscleGroup.rawValue]?.append(movement)
        }
    }
    
    private func addRoutine() {
        let docId = UUID().uuidString
        for movement in selectedMovments {
            selectedMovmentsIDs.append(movement.id)
        }
        let newRoutine = Routine(id: docId, userId: routinesViewModel.userId, name: routineName, icon: selectedIcon, movementIDs: selectedMovmentsIDs)
        Task {
            showProgressView = true
            let result = await routinesViewModel.addRoutine(routine: newRoutine)
            errorHandler.handleAddRoutine(result: result, dismiss: dismiss, dismissBothViews: &dismissBothViews)
        }
    }
}
