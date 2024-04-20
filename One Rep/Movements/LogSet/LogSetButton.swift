//
//  LogSetButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct LogSetButton: View {
    
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
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(setTypeColor).opacity(0.1))
            .cornerRadius(16)
            .customFont(size: .caption, weight: .medium, kerning: 0, design: .rounded)
            .foregroundColor(.white)
        }
    }
}
