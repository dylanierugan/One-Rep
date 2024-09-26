//
//  LogBodyweightSection.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/15/24.
//

import SwiftUI

struct LogBodyweightSection: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var logViewModel: LogViewModel
    
    // MARK: - Public Properties
    
    var movement: Movement
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 16) {
                if logViewModel.addWeightToBodyweight {
                    VStack(spacing: 16) {
                        HStack {
                            Spacer()
                            BodyweightView()
                                .frame(width: 148)
                            Spacer()
                            MutateRepsView()
                            Spacer()
                        }
                        MutateWeightView(isInputActive: _isInputActive)
                    }
                } else {
                    HStack {
                        Spacer()
                        BodyweightView()
                            .frame(width: 148)
                        Spacer()
                        MutateRepsView(isInputActive: _isInputActive)
                            .toolbar {
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
                        Spacer()
                    }
                }
                
                Button {
                    withAnimation {
                        logViewModel.addWeightToBodyweight.toggle()
                    }
                } label: {
                    Text(logViewModel.addWeightToBodyweight ? BodyweightStrings.RemoveWeight.rawValue : BodyweightStrings.AddWeight.rawValue)
                        .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                        .foregroundColor(.secondary).opacity(0.5)
                }
                
                LogSetButton(movement: movement)
                    .padding(.top, 8)
            }
            Spacer()
        }
        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
        .padding(.vertical, 24)
        .background(Color(theme.backgroundElementColor))
    }
}

