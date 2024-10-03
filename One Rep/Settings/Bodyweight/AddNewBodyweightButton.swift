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
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - Public Proporties
    
    @Binding var bodyweight: Double
    @Binding var prevBodyweight: Double
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View
    
    var body: some View {
        Button {
            Task {
                await addBodyweight()
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
    
    // MARK: - Functions
    
    private func addBodyweight() async {
        let bodyweightEntry = await userViewModel.addBodyweightEntry(bodyweight: bodyweight)
        guard let bodyweightEntry = bodyweightEntry else { return }
        userViewModel.bodyweightEntries.insert(bodyweightEntry, at: 0)
        self.prevBodyweight = self.bodyweight
        dismiss()
    }
}
