//
//  LogCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/27/24.
//

import SwiftUI

struct LogCard: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logDataViewModel: LogDataViewModel
    
    var weight: String
    var reps: String
    var date: Double
    
    // MARK: - View
    
    var body: some View {
        HStack {
            HStack {
                TimeLabel(date: date)
                Spacer()
                DataLabel(data: weight, dataType: logDataViewModel.unit.rawValue)
                Spacer()
                DataLabel(data: reps, dataType: "reps")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color(theme.backgroundElementColor))
        .cornerRadius(16)
    }
}

// MARK: - Structs

struct TimeLabel: View {
    var date: Double
    var body: some View {
        HStack {
            Text(Date(timeIntervalSince1970: date), style: .time)
                .foregroundStyle(.secondary)
                .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
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
                .customFont(size: .body, weight: .regular, kerning: 0, design: .rounded)
                .foregroundStyle(.secondary)
        }
    }
}
