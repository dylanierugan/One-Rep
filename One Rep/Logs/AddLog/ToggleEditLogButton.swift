//
//  ToggleEditLogButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/11/24.
//

import SwiftUI

struct ToggleEditLogButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var logViewModel: LogViewModel
    
    // MARK: - Public Properties
    
    @Binding var isEditingLogs: Bool
    
    // MARK: - Private Properties
    
    private var buttonText: String {
        return isEditingLogs ? ToggleEditStrings.Done.rawValue : ToggleEditStrings.Edit.rawValue
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
