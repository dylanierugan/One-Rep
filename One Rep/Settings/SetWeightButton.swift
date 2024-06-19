//
//  SaveWeightButton.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/4/24.
//

import SwiftUI

struct SetWeightButton: View {
    
    // MARK: - Vars
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var theme: ThemeModel
    @Binding var bodyweight: Double
    @Binding var prevBodyweight: Double
    
    var addWeightToRealm: () -> Void
    
    // MARK: - View
    
    var body: some View {
        Button {
            DispatchQueue.main.async {
                self.presentationMode.wrappedValue.dismiss()
                addWeightToRealm()
            }
        } label: {
            HStack {
                Text("Set")
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
