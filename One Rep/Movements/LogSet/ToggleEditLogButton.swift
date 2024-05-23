//
//  ToggleEditLogButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

struct ToggleEditLogButton: View {
    
    // MARK: - Variable
    
    @Binding var isEditingLogs: Bool
    var buttonText: String {
        return isEditingLogs ? "Done" : "Edit"
    }
    
    // MARK: - View
    
    var body: some View {
        Button {
            withAnimation {
                isEditingLogs.toggle()
            }
        } label: {
            Text(buttonText)
                .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
        }
    }
}
