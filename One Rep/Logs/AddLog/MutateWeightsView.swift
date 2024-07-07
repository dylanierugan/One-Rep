//
//  MutateWeightsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import Combine
import SwiftUI

struct MutateWeightView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logController: LogController
    @EnvironmentObject var logViewModel: LogViewModel
    
    @ObservedObject var movementViewModel = MovementViewModel()
    @State var mutatingValue: Double = 5
    
    @FocusState var isInputActive: Bool
    
    let mutatingValues : [Double] = [2.5, 5, 10, 25]
    
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
                .onChange(of: mutatingValue) {
                    Task {
                        movementViewModel.movement.mutatingValue = mutatingValue
                        let result = await movementViewModel.updateMovement()
                        handleResult(result: result, errorMessage: "")
                    }
                }
            } label: {
                HStack {
                    Text("Weight (\(logViewModel.unit.rawValue))")
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
        .onAppear() {
            mutatingValue = movementViewModel.movement.mutatingValue
        }
    }
    
    func handleResult(result: FirebaseResult?, errorMessage: String) {
        guard let result = result else { return }
        switch result {
        case .success:
            return
        case .failure(_):
            print(errorMessage)
            /// TODO - Handle error
        }
    }
}
