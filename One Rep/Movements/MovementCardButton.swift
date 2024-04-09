//
//  MovementCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/25/24.
//

import SwiftUI
import RealmSwift

struct MovementCardButton: View {
    
    @EnvironmentObject var themeColor: ThemeColorModel
    
    var movement: Movement
    @Binding var selectedMovement: Movement?
    
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink {
                /// Logs View
            } label: {
                HStack {
                    HStack(spacing: 20) {
                        ZStack {
//                            Circle()
//                                .foregroundStyle(Color(themeColor.BaseLight).opacity(0.1))
//                                .frame(width: 36, height: 36)
                            Image(movement.muscleGroup.lowercased())
                                .font(.body.weight(.regular))
                                .foregroundStyle(.linearGradient(colors: [
                                    Color(themeColor.BaseLight),
                                    Color(themeColor.Base),
                                    Color(themeColor.BaseDark)
                                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(movement.name)
                                .customFont(size: .title3, weight: .bold, kerning: 1.2, design: .rounded)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                            Text(movement.muscleGroup)
                                .customFont(size: .caption, weight: .regular, kerning: 1, design: .rounded)
                                .foregroundColor(.secondary).opacity(0.5)
                        }
                    }
                    Spacer()
                    Image(systemName: Icons.ChevronForward.description)
                        .font(.caption.weight(.regular))
                        .foregroundColor(.secondary)
                }
                .padding(20)
                .frame(height: 72)
                .background(Color(themeColor.BackgroundElement))
                .cornerRadius(16)
                .padding(.horizontal, 16)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 3, y: 3)
            }
            //            Button {
            //                selectedMovement = movement
            //            } label: {
            //                HStack {
            //                    Image(systemName: Icons.RectangleAndPencilAndEllipsis.description)
            //                        .foregroundColor(Color(Colors.Green.description))
            //                        .font(Font.body.weight(.medium))
            //                        .padding(.horizontal, 16)
            //                }
            //            }
            //            .padding(.top, 40)
            //            .padding(.horizontal, 16)
            //            .sheet(item: $selectedMovement, content: { movement in
            //                EditMovementView()
            //                    .dynamicTypeSize(.xSmall)
            //            })
        }
    }
}
