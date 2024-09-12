//
//  MovementCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/25/24.
//

import SwiftUI

struct MovementCardButton: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties

    var movement: Movement
    
    // MARK: - View
    
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink {
                LogView(movement: movement)
            } label: {
                HStack {
                    HStack() {
                        ZStack {
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
                            .padding(.leading, movement.muscleGroup == .Chest ? 8 : 14)
                    }
                    Spacer()
                }
                .padding(20)
                .frame(height: 52)
                .background(Color(theme.backgroundElementColor))
                .cornerRadius(16)
                .padding(.horizontal, 16)
            }
        }
    }
}
