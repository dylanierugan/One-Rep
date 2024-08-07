//
//  RoutineCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/1/24.
//

import SwiftUI

struct RoutineCard: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var movementsViewModel: MovementsViewModel
    
    // MARK: - Public Properties
    
    var routine: Routine
    
    var body: some View {
        NavigationLink {
            SelectedRoutineView(routineViewModel: RoutineViewModel(routine: routine))
        } label: {
            HStack {
                HStack {
                    HStack {
                        if (routine.icon == Icons.Bench.rawValue) {
                            Image(routine.icon)
                                .font(.caption.weight(.bold))
                        } else {
                            Image(systemName: routine.icon)
                                .font(.body.weight(.bold))
                        }
                    }
                    .foregroundStyle(.linearGradient(colors: [
                        Color(theme.lightBaseColor),
                        Color(theme.darkBaseColor)
                    ], startPoint: .top, endPoint: .bottom))
                    Text(routine.name)
                        .customFont(size: .title3, weight: .semibold, kerning: 0.5, design: .rounded)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.leading, routine.icon == Icons.Bench.rawValue ? 16 : 10)
                    Spacer()
                }
            }
            .padding(20)
            .frame(height: 52)
            .background(Color(theme.backgroundElementColor))
            .cornerRadius(16)
            .padding(.horizontal, 16)
        }
    }
}
