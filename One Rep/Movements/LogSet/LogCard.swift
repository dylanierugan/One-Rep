//
//  LogCard.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/27/24.
//

import SwiftUI
import RealmSwift

struct LogCard: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logDataViewModel: LogDataViewModel
    
    @ObservedRealmObject var log: Log
    @ObservedRealmObject var movement: Movement
    
    @State var showEditMovementPopup = false
    
    @Binding var showDoneToolBar: Bool
    
    // MARK: - View
    
    var body: some View {
        Button {
            showEditMovementPopup.toggle()
            showDoneToolBar = false
        } label: {
            HStack {
                HStack {
                    TimeLabel(date: log.date)
                    Spacer()
                    DataLabel(data: logDataViewModel.convertWeightDoubleToString(log.weight), dataType: logDataViewModel.unit.rawValue)
                    Spacer()
                    DataLabel(data: String(log.reps), dataType: "reps")
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .background(Color(theme.backgroundElementColor))
            .cornerRadius(16)
        }
        .sheet(isPresented: $showEditMovementPopup) {
            EditLogView(log: log, movement: movement)
                .environment(\.sizeCategory, .extraSmall)
                .onDisappear {
                    showDoneToolBar = true
                    logDataViewModel.populateListOfWeights(movement.logs)
                    logDataViewModel.filterWeightAndPopulateData(movement.logs)
                    logDataViewModel.setMostRecentLog(movement.logs)
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
