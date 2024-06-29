//
//  LogWeightSection.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/9/24.
//

import SwiftUI

struct LogWeightSection: View {
    
    // MARK: - Vars
    
    @EnvironmentObject var theme: ThemeModel
    
    @State var movement: Movement
    
    @Binding var showDoneToolBar: Bool
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack(spacing: 8) {
                 MutateWeightView(movement: movement, isInputActive: _isInputActive)
                 MutateRepsView(isInputActive: _isInputActive)
            }
            .toolbar {
                if showDoneToolBar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button {
                            isInputActive = false
                        } label: {
                            Text("Done")
                                .foregroundStyle(.primary)
                                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            
            LogSetButton(movement: movement)
                .padding(.top, 8)
        }
        .padding(.vertical, 24)
        .background(Color(theme.backgroundElementColor))
    }
}
