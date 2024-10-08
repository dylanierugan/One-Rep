//
//  AddRoutineView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/21/24.
//

import SwiftUI

struct AddRoutineView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var routinesViewModel: RoutinesViewModel
    
    // MARK: - Private Properties
    
    @StateObject private var addRoutineViewModel = AddRoutineViewModel()
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                VStack(spacing: 36) {
                    
                    Text(AddRoutineStrings.NewRoutine.rawValue)
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(AddRoutineStrings.RoutineName.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        RoutineNameTextfield(focus: true, routineName: $addRoutineViewModel.routineName, text: "")
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(AddRoutineStrings.RoutineIcon.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        HStack {
                            RoutineIconPicker(selectedIcon: $addRoutineViewModel.selectedIcon)
                        }
                    }
                    
                    SelectMovementsButton(addRoutineViewModel: addRoutineViewModel)
                        .padding(.top, 32)
                }
                .padding(.horizontal, 32)
            }
            .onAppear() {
                if addRoutineViewModel.dismissBothViews {
                    dismiss()
                }
            }
        }
        .accentColor(.primary)
    }
}
