//
//  MovementCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/25/24.
//

import SwiftUI
import RealmSwift

struct MovementCardButton: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var movementViewModel: MovementViewModel
    @ObservedRealmObject var userModel: UserModel
    
    @Binding var selectedMovement: Movement?

    var movement: Movement
    
    // MARK: - View
    
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink {
                MovementSetView(movementViewModel: movementViewModel, movement: movement, userModel: userModel)
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
                .frame(height: 56)
                .background(Color(theme.backgroundElementColor))
                .cornerRadius(16)
                .padding(.horizontal, 16)
            }
        }
    }
}
