//
//  RoutineTitle.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/2/24.
//

import SwiftUI

struct RoutineTitle: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    var routine: Routine
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 12) {
            if routine.icon == Icons.Bench.rawValue {
                Image(routine.icon.lowercased())
                    .font(.caption)
                    .foregroundStyle(.linearGradient(colors: [
                        Color(theme.lightBaseColor),
                        Color(theme.darkBaseColor)
                    ], startPoint: .top, endPoint: .bottom))
                    .padding(.trailing, 8)
            } else {
                Image(systemName: routine.icon)
                    .font(.body)
                    .foregroundStyle(.linearGradient(colors: [
                        Color(theme.lightBaseColor),
                        Color(theme.darkBaseColor)
                    ], startPoint: .top, endPoint: .bottom))
            }
            Text(routine.name)
                .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
        }
    }
}
