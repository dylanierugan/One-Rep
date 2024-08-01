//
//  RoutinesView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/21/24.
//

import SwiftUI

struct RoutinesView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    
    // MARK: - Private Properties
    
    @State private var showAddRoutinePopup = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    // MARK: - View
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                ScrollView {
                    if routinesViewModel.routines.count == 0 {
                        Text(InfoText.CreateNewRoutine.rawValue)
                            .customFont(size: .body, weight: .semibold, kerning: 0.5, design: .rounded)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 36)
                            .padding(.top, 32)
                    }
                }
            }
            .sheet(isPresented: $showAddRoutinePopup) {
                AddRoutineView()
                    .environment(\.sizeCategory, .extraSmall)
                    .environment(\.colorScheme, theme.colorScheme)
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                AddRoutineToolButton(showAddRoutinePopup: $showAddRoutinePopup)
            }
        })
    }
}
