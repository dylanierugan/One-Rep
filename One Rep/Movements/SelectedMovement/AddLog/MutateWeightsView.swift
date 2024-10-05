//
//  MutateWeightsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct MutateWeightView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    @EnvironmentObject var selectedMovementViewModel: SelectedMovementViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Public Properties
    
    @FocusState var isInputActive: Bool
    
    // MARK: - Private Properties
    
    @State private var mutatingValue: Double = 5
    private let mutatingValues : [Double] = [2.5, 5, 10, 25]
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Menu {
                Picker("", selection: $mutatingValue) {
                    ForEach(mutatingValues, id: \.self) { value in
                        Text("± \(value.clean) \(logsViewModel.unit.rawValue)")
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary).opacity(0.7)
                    }
                }
                .onChange(of: mutatingValue) { 
                    Task {
                        await pickerOnChangeSetMutatingValue()
                    }
                }
            } label: {
                HStack {
                    Text("\(MutateStrings.Weight.rawValue) (\(logsViewModel.unit.rawValue))")
                        .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                        .foregroundColor(.secondary).opacity(0.7)
                    Image(systemName: Icons.ChevronCompactDown.rawValue)
                        .foregroundColor(.secondary).opacity(0.7)
                }
                .frame(maxWidth: 100)
            }
            .padding(.bottom, 6)
            
            HStack {
                MutateWieghtButton(isEditing: false, color: .primary,
                                   icon: Icons.Minus.rawValue,
                                   mutatingValue: -selectedMovementViewModel.movement.mutatingValue)
                
                TextField("", value: $logViewModel.weight, formatter: NumberFormatter.noDecimalUnlessNeeded)
                    .accentColor(Color(theme.darkBaseColor))
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .padding(.vertical, 8)
                    .frame(width: 68, alignment: .center)
                    .cornerRadius(10)
                    .customFont(size: .title2, weight: .semibold, kerning: 0, design: .rounded)
                    .focused($isInputActive)
                    .onTapGesture {
                        logViewModel.weight = nil
                    }
                
                MutateWieghtButton(isEditing: false, color: .primary,
                                   icon: Icons.Plus.rawValue, mutatingValue: selectedMovementViewModel.movement.mutatingValue)
            }
        }
        .onAppear() { mutatingValue = selectedMovementViewModel.movement.mutatingValue }
    }
    
    // MARK: - Functions
    
    private func pickerOnChangeSetMutatingValue() async {
        selectedMovementViewModel.movement.mutatingValue = mutatingValue
        selectedMovementViewModel.updateMovementMutatingValue(userId: userViewModel.userId)
        movementsViewModel.updateMovementInList(selectedMovementViewModel.movement)
    }
}
