//
//  LogSetButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct LogSetButton: View {
    
    // MARK: - Variables
    
    @Binding var setTypeSelection: String
    @Binding var setTypeColorDark: Color
    @Binding var setTypeColorLight: Color
    
    // MARK: - View
    
    var body: some View {
        Button {
            /// TODO
        } label: {
            HStack {
                Text("Log \(setTypeSelection)")
                    .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundStyle(
                        .linearGradient(colors:
                                            [Color(setTypeColorLight),
                                             Color(setTypeColorDark)],
                                        startPoint: .top, endPoint: .bottom)
                    )
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(setTypeColorLight).opacity(0.1))
            .cornerRadius(16)
            .customFont(size: .caption, weight: .medium, kerning: 0, design: .rounded)
            .foregroundColor(.white)
        }
    }
}
