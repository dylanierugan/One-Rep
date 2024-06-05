//
//  BodyweightTextField.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/3/24.
//

import Combine
import SwiftUI

struct BodyweightTextField: View {
    
    // MARK: - Vars
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logViewModel: LogViewModel
    
    @State var focus: Bool
    @FocusState var isFocused: Bool
    @FocusState var isInputActive: Bool
    
    @Binding var bodyweightStr: String
    @Binding var bodyweight: Double
    
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            HStack {
                TextField("", text: $bodyweightStr)
                    .onChange(of: bodyweightStr) { newText, _ in
                        bindWeightValues()
                    }
                    .task {
                        if focus {
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(550)) {
                                self.isFocused = true
                            }
                        }
                    }
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    .accentColor(Color(theme.darkBaseColor))
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                    .padding(.vertical, 8)
                    .focused($isFocused)
                    .frame(width: 72, alignment: .center)
                    .cornerRadius(10)
                    .onReceive(Just(bodyweight)) { _ in limitWeightText(3) }
                    .focused($isInputActive)
                Spacer()
                Text(logViewModel.unit.rawValue)
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                    .padding(.horizontal, 16)
            }
            .padding(.vertical, 8)
            .background(.secondary.opacity(0.05))
            .cornerRadius(16)
            /// Button to increase textField hitbox
            Button {
                isFocused = true
            } label: {
                Text("")
                    .frame(width: UIScreen.main.bounds.width - 32, height: 24, alignment: .center)
                    .padding(10)
                    .background(.clear)
            }
        }
    }
    
    // MARK: - View
    
    func bindWeightValues() {
        if bodyweightStr.isEmpty {
            bodyweight = 0.0
        } else if let value = Double(bodyweightStr) {
            bodyweight = value
            updateWeightString()
        } else {
            bodyweightStr = formatWeightString(bodyweight)
        }
    }
    
    func updateWeightString() {
        bodyweightStr = formatWeightString(bodyweight)
    }
    
    func formatWeightString(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
    
    func limitWeightText(_ upper: Int) {
        if bodyweightStr.count > upper {
            bodyweightStr = String(bodyweightStr.prefix(upper))
        }
    }
}
