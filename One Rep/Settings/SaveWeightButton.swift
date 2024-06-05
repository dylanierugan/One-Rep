//
//  SaveWeightButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/4/24.
//

import SwiftUI

struct SaveWeightButton: View {
    
    // MARK: - Vars
    
    @EnvironmentObject var theme: ThemeModel
    @Binding var bodyweight: Double
    @Binding var prevBodyweight: Double
    
    var addWeightToRealm: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            addWeightToRealm()
        } label: {
            HStack {
                Text("Save")
                    .foregroundStyle(prevBodyweight != bodyweight ?
                        .linearGradient(colors: [
                            Color(theme.lightBaseColor),
                            Color(theme.darkBaseColor)
                        ], startPoint: .top, endPoint: .bottom) :
                            .linearGradient(colors: [
                                .secondary
                            ], startPoint: .top, endPoint: .bottom))
                    .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
            }
        }
    }
}
