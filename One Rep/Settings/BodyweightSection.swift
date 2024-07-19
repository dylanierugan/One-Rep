//
//  WeightSection.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/3/24.
//

import SwiftUI

struct BodyweightSection: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(BodyweightStrings.Bodyweight.rawValue)
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary)
            NavigationLink {
                RecordBodyweightView(fromSettingsView: true)
            } label: {
                VStack(alignment: .leading) {
                    HStack(spacing: 24) {
                        HStack(spacing: 16) {
                            Image(systemName: Icons.FigureArmsOpen.rawValue)
                                .fontWeight(.black)
                            Text(BodyweightStrings.SetBodyweight.rawValue)
                        }
                        .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                        Spacer()
                        Image(systemName: Icons.ChevronRight.rawValue)
                            .font(.caption).bold()
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 16)
                }
                .frame(height: 48)
                .background(Color(theme.backgroundElementColor))
                .cornerRadius(16)
            }
        }
    }
}
