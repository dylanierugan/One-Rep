//
//  LogCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/27/24.
//

import SwiftUI

struct LogCard: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logController: LogController
    @EnvironmentObject var logViewModel: LogViewModel
    
    @State var log: Log
    @State var movement: Movement
    @State var showEditMovementPopup = false
    var index: Int
    
    @Binding var showDoneToolBar: Bool
    
    // MARK: - View
    
    var body: some View {
        Button {
            showEditMovementPopup.toggle()
            showDoneToolBar = false
        } label: {
                HStack {
                    HStack(alignment: .bottom) {
                        Text("Set")
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            .foregroundStyle(.secondary)
                        Text(String(index))
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            .foregroundStyle(.primary)
                    }
                    Spacer()
                    HStack(spacing: 32) {
                        DataLabel(data: logViewModel.convertWeightDoubleToString(log.weight), dataType: logViewModel.unit.rawValue)
                        DataLabel(data: String(log.reps), dataType: "reps")
                    }
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 6)
        }
        .sheet(isPresented: $showEditMovementPopup) {
            EditLogView(log: $log, movement: movement)
                .environment(\.sizeCategory, .extraSmall)
                .onDisappear {
                    showDoneToolBar = true
                }
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
