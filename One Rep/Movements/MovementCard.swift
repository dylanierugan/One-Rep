//
//  MovementCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/25/24.
//

import SwiftUI
import RealmSwift

struct MovementCard: View {
    
    var movement: Movement
    @Binding var selectedMovement: Movement?
    
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink {
                // TODO: Weights View
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(movement.name)
                            .font(.title2.weight(.bold))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 14)
                        Spacer()
                        HStack {
                            Image(movement.muscleGroup.lowercased())
                                .font(.custom("custom18", size: 18))
                            Text(movement.muscleGroup)
                                .font(.callout.weight(.regular))
                                .foregroundColor(.secondary)
                                .padding(.leading, 8)
                        }
                        .padding(.leading, 4)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    Spacer()
                    VStack {
                        Image(systemName: Icons.ChevronForward.description)
                            .font(.body.weight(.regular))
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                }
                .background(.ultraThickMaterial.opacity(0.4))
                .cornerRadius(10)
                .padding(.horizontal, 16)
            }
            Button {
                selectedMovement = movement
            } label: {
                HStack {
                    Image(systemName: Icons.RectangleAndPencilAndEllipsis.description)
                        .font(Font.body.weight(.medium))
                        .padding(.horizontal, 16)
                }
            }
            .padding(.top, 40)
            .padding(.horizontal, 16)
            .sheet(item: $selectedMovement, content: { movement in
                // TODO: Edit Movement View
            })
        }
    }
}
