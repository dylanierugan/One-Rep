//
//  BodyweightView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/15/24.
//

import SwiftUI

struct BodyweightView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    // MARK: - View
    
    var body: some View {
        NavigationLink {
            RecordBodyweightView(fromSettingsView: false)
        } label: {
            VStack(spacing: 12) {
                Text(BodyweightStrings.Bodyweight.rawValue)
                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                    .foregroundColor(.secondary).opacity(0.7)
                HStack {
                    if let bodyweightEntry = userViewModel.bodyweightEntries.first {
                        Image(systemName: Icons.FigureArmsOpen.rawValue)
                            .fontWeight(.black)
                        Text("\(bodyweightEntry.bodyweight.clean)  \(logsViewModel.unit.rawValue)")
                    }
                }
            }
        }
    }
}
