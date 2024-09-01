//
//  TabHolderView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI

struct TabHolderView: View {
    
    // MARK: - View
    
    var body: some View {
        TabView {
            MovementSectionHolderView()
                .tabItem {
                    Image(systemName: Icons.FigureStrengthTraining.rawValue)
                }
            SettingsView()
                .tabItem {
                    Image(systemName: Icons.PersonFill.rawValue)
                }
        }
        .font(.headline)
        .accentColor(.primary)
    }
}
