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
    @EnvironmentObject var logController: LogController
    @EnvironmentObject var logViewModel: LogViewModel
    
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
                    DataLabel(data: logViewModel.convertWeightDoubleToString(log.weight), dataType: logViewModel.unit.rawValue)
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
                    logViewModel.populateListOfWeights(movement.logs)
                    logViewModel.filterWeightAndPopulateData(movement.logs)
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
