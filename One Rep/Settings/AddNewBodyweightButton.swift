//
//  SaveWeightButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/4/24.
//

import SwiftUI

struct AddNewBodyweightButton: View {
    
    // MARK: - Global Proporties
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Proporties
    
    @Binding var bodyweight: Double
    @Binding var prevBodyweight: Double
    var addBodyweightToFirebase: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            DispatchQueue.main.async {
                addBodyweightToFirebase()
            }
        } label: {
            HStack {
                Text(BodyweightStrings.Set.rawValue)
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
        .disabled(prevBodyweight != bodyweight ? false : true)
    }
}
