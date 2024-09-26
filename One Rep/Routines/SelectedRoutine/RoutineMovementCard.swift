//
//  RoutineMovementCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/2/24.
//

import SwiftUI

struct RoutineMovementCard: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    var index: Int
    var movement: Movement
    
    // MARK: - Private Properties
    
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 24) {
                Text(String(index))
                    .foregroundColor(.primary)
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(movement.name)
                            .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                    }
                    Text(movement.muscleGroup.rawValue)
                        .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: Icons.ChevronRight.rawValue)
                    .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
                    .foregroundColor(.secondary)
            }
            .padding(20)
            .frame(height: 52)
            .background(Color(theme.backgroundElementColor))
            .cornerRadius(16)
            NavigationLink(destination: SelectedMovementView(movement: movement)) {
                EmptyView()
            } .opacity(0)
        }
    }
}
