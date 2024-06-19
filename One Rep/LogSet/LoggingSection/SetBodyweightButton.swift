//
//  AddBodyweightView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/9/24.
//

import SwiftUI
import RealmSwift

struct SetBodyweightButton: View {
    
    // MARK: - Vars
    
    @EnvironmentObject var theme: ThemeModel
    @ObservedRealmObject var userModel: UserModel
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Spacer()
            
            NavigationLink {
                RecordBodyweightView(userModel: userModel, fromSettingsView: false)
            } label: {
                HStack {
                    Text("Set  bodyweight")
                    Image(systemName: Icons.FigureArmsOpen.description)
                }
                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                .foregroundColor(.primary)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(.secondary.opacity(0.05))
            .cornerRadius(16)

            Spacer()
        }
        .padding(.vertical, 48)
        .background(Color(theme.backgroundElementColor))
    }
}
