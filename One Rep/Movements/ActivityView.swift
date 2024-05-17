//
//  ActivityView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/14/24.
//

import SwiftUI
import RealmSwift

struct ActivityView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var logDataController: LogDataController
    
    @ObservedRealmObject var movementModel: MovementViewModel
    
    // MARK: - View
    var body: some View {
        VStack {
            ForEach(0..<logDataController.listOfDates.count, id: \.self) { index in
                let date = logDataController.listOfDates.reversed()[index]
                VStack {
                    Section(header: HStack {
                        Text(date)
                            .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        Spacer()
                    }
                    ){
                        if let movementLogMap = logDataController.dateMovementLogMap[date] {
                            ForEach(Array(movementLogMap.keys), id: \.self) { movement in
                                VStack(alignment: .leading) {
                                    Text(movement.name)
                                        .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                    if let logs = movementLogMap[movement]{
                                        ForEach(logs.reversed() , id: \.id) { log in
                                            let weightStr = logDataController.convertWeightDoubleToString(log.weight)
                                            let repStr = String(log.reps)
                                            HStack {
                                                Text(Date(timeIntervalSince1970: log.date), style: .time)
                                                    .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
                                                    .foregroundStyle(.primary)
                                                Spacer()
                                                HStack {
                                                    Text(weightStr)
                                                        .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                                                        .foregroundStyle(.primary)
                                                    Text("lbs")
                                                        .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
                                                        .foregroundStyle(.secondary)
                                                }
                                                Spacer()
                                                HStack {
                                                    Text(repStr)
                                                        .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                                                        .foregroundStyle(.primary)
                                                    Text("reps")
                                                        .customFont(size: .caption, weight: .semibold, kerning: 0, design: .rounded)
                                                        .foregroundStyle(.secondary)
                                                }
                                            }
                                            .padding(.horizontal, 16)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Divider().padding(.horizontal, 16)
                        .padding(.top, 16)
                }
            }

        }
        .onAppear() {
            let logs = logDataController.getAllLogs(movementModel.movements)
            logDataController.populateListOfDates(logs)
            logDataController.populateDateMovementLogMap(logs)
        }
    }
}
