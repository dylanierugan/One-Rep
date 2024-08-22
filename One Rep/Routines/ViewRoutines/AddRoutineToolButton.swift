//
//  AddRoutineToolButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/21/24.
//

import SwiftUI

struct AddRoutineToolButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    @Binding var showAddRoutinePopup: Bool
    
    // MARK: - View
    
    var body: some View {
        Button {
            showAddRoutinePopup = true
        } label: {
            HStack {
                Image(systemName: Icons.NoteTextBadgePlus.rawValue)
                    .font(.body.bold())
                    .foregroundStyle(.primary)
            }
        }
    }
}
