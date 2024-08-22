//
//  BodyweightTextField.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/3/24.
//

import Combine
import SwiftUI

struct BodyweightTextField: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    @State var focus: Bool
    @FocusState var isFocused: Bool
    @FocusState var isInputActive: Bool
    
    @Binding var bodyweight: Double
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            HStack {
                TextField("", value: $bodyweight,
                          formatter: NumberFormatter.noDecimalUnlessNeeded)
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
                    .focused($isInputActive)
                Spacer()
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
}
