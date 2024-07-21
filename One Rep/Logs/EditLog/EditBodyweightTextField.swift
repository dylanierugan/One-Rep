//
//  EditBodyweightTextField.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/20/24.
//

import SwiftUI

struct EditBodyweightTextField: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var logController: LogController
    
    // MARK: - Public Properties
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        TextField("", value: $logController.editBodyweight,
                  formatter: NumberFormatter.noDecimalUnlessNeeded)
        .accentColor(Color(theme.darkBaseColor))
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(.secondary.opacity(0.05))
        .frame(width: 100, alignment: .center)
        .cornerRadius(10)
        .customFont(size: .title3, weight: .semibold, kerning: 0, design: .rounded)
        .focused($isInputActive)
    }
}
