//
//  MutateWeightsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import Combine
import SwiftUI

struct MutateWeightView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logController: LogController
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var errorHandler: ErrorHandler
    @ObservedObject var movementViewModel = MovementViewModel()
    
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
                        Text("± \(value.clean) \(logViewModel.unit.rawValue)")
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary).opacity(0.7)
                    }
                }
                .onChange(of: mutatingValue) { pickerOnChangeSetMutatingValue() }
            } label: {
                HStack {
                    Text("\(MutateStrings.Weight.rawValue) (\(logViewModel.unit.rawValue))")
                        .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                        .foregroundColor(.secondary).opacity(0.7)
                    Image(systemName: Icons.ChevronCompactDown.rawValue)
                        .foregroundColor(.secondary).opacity(0.7)
                }
                .frame(maxWidth: 100)
            }
            .padding(.bottom, 6)
            
            HStack {
                MutateWieghtButton(isEditing: false, color: .primary, icon: Icons.Minus.rawValue, mutatingValue: -movementViewModel.movement.mutatingValue)
                
                TextField("", value: $logController.weight, formatter: NumberFormatter.noDecimalUnlessNeeded)
                    .accentColor(Color(theme.darkBaseColor))
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .padding(.vertical, 8)
                    .frame(width: 68, alignment: .center)
                    .cornerRadius(10)
                    .customFont(size: .title2, weight: .semibold, kerning: 0, design: .rounded)
                    .focused($isInputActive)
                
                MutateWieghtButton(isEditing: false, color: .primary, icon: Icons.Plus.rawValue, mutatingValue: movementViewModel.movement.mutatingValue)
            }
        }
        .onAppear() { mutatingValue = movementViewModel.movement.mutatingValue }
    }
    
    // MARK: - Functions
    
    private func pickerOnChangeSetMutatingValue() {
        Task {
            movementViewModel.movement.mutatingValue = mutatingValue
            let result = await movementViewModel.updateMovement()
            errorHandler.handleResult(result: result)
        }
    }
    
}
