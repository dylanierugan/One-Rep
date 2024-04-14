//
//  LogSetButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct LogSetButton: View {
    
    @EnvironmentObject var theme: ThemeModel
    @Binding var setTypeSelection: String
    @Binding var setTypeColor: Color
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Text("Log \(setTypeSelection)")
                    .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundColor(Color(setTypeColor))
            }
            .cornerRadius(16)
            .customFont(size: .caption, weight: .medium, kerning: 0, design: .rounded)
            .foregroundColor(.white)
        }
    }
}
