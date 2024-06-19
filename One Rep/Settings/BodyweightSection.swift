//
//  WeightSection.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/3/24.
//

import SwiftUI
import RealmSwift

struct BodyweightSection: View {
    
    // MARK: - Vars
    
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var userModel: UserModel
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Body weight")
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                .foregroundColor(.secondary)
            NavigationLink {
                RecordBodyweightView(userModel: userModel, fromSettingsView: true)
            } label: {
                VStack(alignment: .leading) {
                    HStack(spacing: 24) {
                        HStack(spacing: 16) {
                            Image(systemName: Icons.FigureArmsOpen.description)
                                .fontWeight(.black)
                            Text("Set  bodyweight")
                        }
                        .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                        Spacer()
                        Image(systemName: Icons.ChevronRight.description)
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
