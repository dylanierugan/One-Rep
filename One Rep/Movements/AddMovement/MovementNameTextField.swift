//
//  CustomTextField.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import SwiftUI

struct MovementNameTextField: View {
    
    @EnvironmentObject var theme: ThemeModel
    
    var text: String
    @Binding var movementName: String
    @FocusState var isFocused: Bool
    @State var focus: Bool

    var body: some View {
        ZStack {
            TextField(text, text: $movementName)
                .font(.body.weight(.regular))
                .padding(12)
                .background(Color(theme.BackgroundElementColor))
                .cornerRadius(16)
                .textInputAutocapitalization(.words)
                .accentColor(Color(theme.BaseColor))
                .focused($isFocused)
                .task {
                    if focus {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(550)) {
                                self.isFocused = true
                            }
                    }
                }
            /// Button to increase textField hitbox
            Button {
                isFocused = true
            } label: {
                Text("")
                    .frame(width: UIScreen.main.bounds.width - 45, height: 25, alignment: .center)
                    .padding(10)
                    .background(.clear)
            }
        }
    }
}


