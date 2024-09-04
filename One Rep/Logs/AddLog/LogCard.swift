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
    
    @State var log: Log
    @State var movement: Movement
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
                        DataLabel(data: logsViewModel.convertWeightDoubleToString(log.weight + log.bodyweight),
                                  dataType: log.unit.rawValue)
                        DataLabel(data: String(log.reps),
                                  dataType: LogCardStrings.Reps.rawValue)
                    }
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 6)
        }
        .sheet(isPresented: $showEditMovementPopup) {
            EditLogView(log: $log,
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

struct DataLabel: View {
    var data: String
    var dataType: String
    var body: some View {
        HStack {
            Text(data)
                .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                .foregroundStyle(.primary)
            Text(dataType)
                .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                .foregroundStyle(.secondary)
        }
    }
}
