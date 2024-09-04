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
    
    @State private var routineName = ""
    @State private var selectedIcon = Icons.Bench.rawValue
    @State private var showProgressView = false
    @State private var dismissBothViews = false
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        !routineName.isEmpty
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                VStack(spacing: 36) {
                    
                    /// Title
                    Text(AddRoutineStrings.NewRoutine.rawValue)
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    
                    /// Textfield
                    VStack(alignment: .leading, spacing: 6) {
                        Text(AddRoutineStrings.RoutineName.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        RoutineNameTextfield(focus: false, routineName: $routineName, text: "")
                    }
                    
                    /// Icon Picker
                    VStack(alignment: .leading, spacing: 6) {
                        Text(AddRoutineStrings.RoutineIcon.rawValue)
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        HStack {
                            RoutineIconPicker(selectedIcon: $selectedIcon)
                        }
                    }
                    
                    /// Select movments
                    SelectMovementsButton(routineName: $routineName, selectedIcon: $selectedIcon, dismissBothViews: $dismissBothViews, isFormValid: isFormValid)
                        .padding(.top, 32)
                }
                .padding(.horizontal, 32)
            }
            .onAppear() {
                if dismissBothViews {
                    dismiss()
                }
            }
        }
        .accentColor(.primary)
    }
}
