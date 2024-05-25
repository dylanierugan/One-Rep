//
//  UnitView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/22/24.
//

import SwiftUI

struct UnitSection: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Units")
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary)
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    UnitPickerButton(unitSelection: .lbs)
                    UnitPickerButton(unitSelection: .kgs)
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 48)
            .background(Color(theme.backgroundElementColor))
            .cornerRadius(16)
        }
    }
}

struct UnitPickerButton: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logViewModel: LogViewModel
    
    var unitSelection: UnitSelection
    
    // MARK: - View
    
    var body: some View {
        Button(action: {
            withAnimation() {
                logViewModel.unit = unitSelection
                HapticManager.instance.impact(style: .soft)
            }
        }, label: {
            HStack {
                Text(unitSelection.rawValue)
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
            }
            .frame(width: 32, height: 28)
            .foregroundStyle(unitSelection == logViewModel.unit ? .primary: .secondary)
        })
    }
}
