//
//  LogCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/27/24.
//

import SwiftUI

struct LogCard: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logsViewModel: LogsViewModel
    @EnvironmentObject var logViewModel: LogViewModel
    @EnvironmentObject var editLogViewModel: EditLogViewModel
    
    // MARK: - Public Properties
    
    var log: Log
    var movement: Movement
    @Binding var showDoneToolBar: Bool
    var index: Int
    
    // MARK: - Private Properties
    
    @State private var showEditMovementPopup = false
    
    // MARK: - View
    
    var body: some View {
        Button {
            showEditMovementPopup.toggle()
            showDoneToolBar = false
        } label: {
                HStack {
                    HStack(alignment: .bottom) {
                        Text(LogCardStrings.Set.rawValue)
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            .foregroundStyle(.secondary)
                        Text(String(index))
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            .foregroundStyle(.primary)
                    }
                    Spacer()
                    HStack(spacing: 32) {
                        DataLabelWeight(log: log)
                        DataLabelReps(log: log)
                    }
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 6)
        }
        .sheet(isPresented: $showEditMovementPopup) {
            EditLogView(log: log,
                        movement: movement,
                        logViewModel: logViewModel)
                .environment(\.sizeCategory, .extraSmall)
                .environment(\.colorScheme, theme.colorScheme)
                .onDisappear { showDoneToolBar = true }
        }
    }
}

// MARK: - Structs

struct TimeLabel: View {
    var date: Double
    var body: some View {
        HStack {
            Text(Date(timeIntervalSince1970: date), style: .time)
                .foregroundStyle(.secondary)
                .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
        }
    }
}

struct DataLabelWeight: View {
    
    @EnvironmentObject var logsViewModel: LogsViewModel
    
    var log: Log
    
    var body: some View {
        HStack {
            if log.isBodyWeight {
                if log.weight != 0 {
                    Text(logsViewModel.convertWeightDoubleToString(log.weight))
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                        .foregroundStyle(.primary)
                    Text("+")
                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                        .foregroundStyle(.secondary)
                }
                Text(logsViewModel.convertWeightDoubleToString(log.bodyweight))
                    .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundStyle(.primary)
                Image(systemName: Icons.FigureArmsOpen.rawValue)
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundStyle(.primary)
            } else {
                Text(logsViewModel.convertWeightDoubleToString(log.weight))
                    .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundStyle(.primary)
            }
            Text(log.unit.rawValue)
                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                .foregroundStyle(.secondary)
        }
    }
}

struct DataLabelReps: View {
    
    var log: Log
    
    var body: some View {
        HStack {
            Text("\(log.reps)")
                .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                .foregroundStyle(.primary)
            Text(LogCardStrings.Reps.rawValue)
                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                .foregroundStyle(.secondary)
        }
    }
}
