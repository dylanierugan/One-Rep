//
//  CustomTextField.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/19/24.
//

import Combine
import SwiftUI

struct MovementNameTextField: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    @State var focus: Bool
    @Binding var movementName: String
    @FocusState var isFocused: Bool
    var text: String
    
    // MARK: - View

    var body: some View {
        ZStack {
            TextField(text, text: $movementName)
                .font(.body.weight(.regular))
                .padding(12)
                .background(Color(theme.backgroundElementColor))
                .cornerRadius(16)
                .textInputAutocapitalization(.words)
                .accentColor(Color(theme.lightBaseColor))
                .focused($isFocused)
                .onReceive(Just(movementName)) { _ in limitText(30) }
                .task {
                    if focus {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(550)) {
                                self.isFocused = true
                            }
                    }
                }
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
    
    // MARK: - Functions
    
    private func limitText(_ upper: Int) {
        if movementName.count > upper {
            movementName = String(movementName.prefix(upper))
        }
    }
}
