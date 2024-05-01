//
//  LogCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/27/24.
//

import SwiftUI

struct LogCard: View {
    
    @EnvironmentObject var theme: ThemeModel
    
    var repType: RepType
    var weight: String
    var reps: String

    var setProperties: (String, String, String) {
        switch repType {
        case .WorkingSet:
            return (Icons.DumbellFill.description, theme.lightBlue, theme.darkBlue)
        case .WarmUp:
            return (Icons.FlameFill.description, theme.lightOrange, theme.darkOrange)
        case .PR:
            return (Icons.MedalFill.description, theme.lightYellow, theme.darkYellow)
        }
    }
    
    var color: String {
        switch repType {
        case .WorkingSet:
            return theme.lightBlue
        case .WarmUp:
            return Icons.FlameFill.description
        case .PR:
            return Icons.MedalFill.description
        }
    }
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: setProperties.0)
                    .font(.body)
                    .foregroundStyle(.linearGradient(colors: [
                        Color(setProperties.1),
                        Color(setProperties.2),
                    ], startPoint: .top, endPoint: .bottom))
                Spacer()
                if repType != .PR {
                    DataLabel(data: reps, dataType: "reps")
                } else {
                    DataLabel(data: "1", dataType: "rep")
                }
                Spacer()
                DataLabel(data: weight, dataType: "lbs")
                Spacer()
                Text("2:39pm")
                    .foregroundStyle(.secondary)
                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(Color(theme.BackgroundElementColor))
        .cornerRadius(16)
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
