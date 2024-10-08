//
//  LogListView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/7/24.
//

import SwiftUI

struct LogListView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Public Properties
    
    var movement: Movement
    @ObservedObject var logsViewModel: LogsViewModel
    @ObservedObject var selectedMovementViewModel: SelectedMovementViewModel
    
    @Binding var isEditingLogs: Bool
    @Binding var showLogSetView: Bool
    @Binding var showDoneToolBar: Bool
    @Binding var selectedLog: Log
    
    // MARK: - View
    
    var body: some View {
        ForEach(0..<logsViewModel.listOfDates.count, id: \.self) { index in
            let date = logsViewModel.listOfDates[index]
            Section(header: HStack {
                Text(date)
                    .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    .foregroundColor(.primary)
                Spacer()
                if index == 0 {
                    ToggleEditLogButton(isEditingLogs: $isEditingLogs)
                        .padding(.horizontal, 8)
                    ShowFullScreenButton(showLogSetView: $showLogSetView)
                }
            }
                .padding(.horizontal, 20))
            {
                VStack {
                    if let logs = logsViewModel.dateLogMap[date] {
                        VStack {
                            ForEach(Array(logs.reversed().enumerated()), id: \.element.id) { index, log in
                                HStack {
                                    VStack {
                                        LogCard(selectedMovementViewModel: selectedMovementViewModel,
                                                log: log,
                                                movement: movement,
                                                showDoneToolBar: $showDoneToolBar,
                                                index: index + 1)
                                    }
                                    if isEditingLogs {
                                        DeleteLogTrashIconButton(selectedMovementViewModel: selectedMovementViewModel,
                                                                 movement: movement,
                                                                 log: log)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 8)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color(theme.backgroundElementColor))
                .cornerRadius(16)
                .padding(.horizontal, 16)
            }
        }
    }
}
