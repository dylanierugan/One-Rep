//
//  MovementCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/25/24.
//

import SwiftUI
import RealmSwift

struct MovementCardButton: View {
        
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var movementViewModel: MovementViewModel
    
    @Binding var selectedMovement: Movement?

    var movement: Movement
    
    // MARK: - View
    
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink {
                MovementSetView(movementViewModel: movementViewModel, movement: movement)
            } label: {
                HStack {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .frame(width: 36, height: 36)
                                .foregroundStyle(Color(theme.darkBaseColor).opacity(0.15))
                            Image(movement.muscleGroup.rawValue.lowercased())
                                .font(.body.weight(.regular))
                                .foregroundStyle(.linearGradient(colors: [
                                    Color(theme.lightBaseColor),
                                    Color(theme.darkBaseColor)
                                ], startPoint: .top, endPoint: .bottom))
                        }
                        Text(movement.name)
                            .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    Image(systemName: Icons.ChevronForward.description)
                        .font(.caption.weight(.bold))
                        .foregroundColor(.secondary)
                }
                .padding(20)
                .frame(height: 64)
                .background(Color(theme.backgroundElementColor))
                .cornerRadius(16)
                .padding(.horizontal, 16)
            }
        }
    }
}
