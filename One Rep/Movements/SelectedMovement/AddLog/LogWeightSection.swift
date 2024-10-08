//
//  LogWeightSection.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/9/24.
//

import SwiftUI

struct LogWeightSection: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    @State var movement: Movement
    @Binding var showDoneToolBar: Bool
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack(spacing: 8) {
                MutateWeightView(isInputActive: _isInputActive)
                Spacer()
                MutateRepsView(isInputActive: _isInputActive)
            }
            .toolbar {
                if showDoneToolBar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button {
                            isInputActive = false
                        } label: {
                            Text(KeyboardStrings.Done.rawValue)
                                .foregroundStyle(.primary)
                                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                        }
                    }
                }
            }
            .padding(.horizontal, 28)
            
            LogSetButton(movement: movement)
                .padding(.top, 8)
        }
        .padding(.vertical, 16)
        .background(Color(theme.backgroundElementColor))
    }
}
