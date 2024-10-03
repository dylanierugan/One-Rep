//
//  LogViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/28/24.
//

import Foundation

@MainActor
class LogsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var logs = [Log]()
    
    @Published var filteredLogs = [Log]()
    @Published var listOfWeights = [String]()
    @Published var weightLogMap = [String: [Log]]()
    @Published var listOfDates = [String]()
    @Published var dateLogMap = [String: [Log]]()
    
    enum WeightSelectionEnum {
        case allSelected
        case weightSelected
    }
    
    @Published var weightSelection: String = "All"
    @Published var weightSelectionEnum: WeightSelectionEnum = .allSelected
    @Published var showWeightSelection = false
    
    @Published var logsLoading = true
    
    @Published var unit: UnitSelection
    
    private let networkManager = LogsNetworkManager()
    
    // MARK: - Initializer
    
    init(unit: UnitSelection) {
        self.unit = unit
    }
    
    // MARK: - Functions
    
    func loadLogs(userId: String, movements: [Movement]) async {
        defer { logsLoading = false }
        do {
            logs = try await LogsNetworkManager.shared.getLogs(userId: userId, movements: movements)
        } catch {
            // TODO: Handle error
        }
    }
    
    func deleteAllMovementLogs(userId: String, movement: Movement) async {
        filterLogsByMovement(movementId: movement.id)
        do {
            try await LogsNetworkManager.shared.deleteAllMovementLogs(userId: userId, movement: movement, logs: filteredLogs)
        } catch {
            // TODO: Handle error
        }
    }
    
    func deleteAllUserLogs(userId: String, movements: [Movement]) async {
        do {
            try await LogsNetworkManager.shared.deleteAllLogs(userId: userId, movements: movements, logs: logs)
            clearLogs()
        } catch {
            // TODO: Handle error
        }
    }
    
    func updateLogInLocalList(_ updatedLog: Log) {
        if let index = logs.firstIndex(where: { $0.id == updatedLog.id }) {
            logs[index] = updatedLog
        }
    }
    
    func deleteLogInLocalList(_ log: Log) {
        if let index = logs.firstIndex(where: { $0.id == log.id }) {
            logs.remove(at: index)
        }
    }
    
    func clearLogs() {
        logs = []
    }
    
    func filterLogsByMovement(movementId: String) {
        filteredLogs = logs.filter { $0.movementId == movementId }
        filteredLogs.sort { $0.timeAdded > $1.timeAdded }
    }
    
    func setWeightSelectionEnum(weightSelection: String) {
        if weightSelection == "All" {
            self.weightSelectionEnum = .allSelected
        } else {
            self.weightSelectionEnum = .weightSelected
        }
    }
    
    func filterLogsByWeightSelection(weightSelection: String, movementId: String) {
        setWeightSelectionEnum(weightSelection: weightSelection)
        switch weightSelectionEnum {
        case .allSelected:
            filterLogsByMovement(movementId: movementId)
            populateListOfDates()
            populateDateLogMap()
            return
        case .weightSelected:
            let weightDouble = Double(weightSelection)
            filterLogsByMovement(movementId: movementId)
            filteredLogs = filteredLogs.filter { $0.weight == weightDouble }
            filteredLogs.sort { $0.timeAdded > $1.timeAdded }
            populateListOfDates()
            populateDateLogMap()
        }
    }
    
    func populateListOfWeights() {
        listOfWeights = Array(Set(filteredLogs.map { convertWeightDoubleToString($0.weight) }))
        listOfWeights.sort { $0.localizedStandardCompare($1) == .orderedAscending }
        listOfWeights.insert(WeightSelection.All.rawValue, at: 0)
        print(listOfWeights)
        print(listOfWeights.count)
        if listOfWeights.count > 2 {
            showWeightSelection = true
        } else {
            showWeightSelection = false
        }
    }
    
    func populateWeightLogMap() {
        weightLogMap = Dictionary(grouping: filteredLogs) { convertWeightDoubleToString($0.weight) }
    }
    
    func checkIfWeightDeleted(movementId: String, weightSelection: String) -> Bool {
        filterLogsByMovement(movementId: movementId)
        populateWeightLogMap()
        return weightLogMap[weightSelection] == nil
    }
    
    func populateListOfDates() {
        listOfDates = []
        for log in filteredLogs {
            let stringDate = formatDate(date: log.timeAdded.timeIntervalSince1970)
            if !self.listOfDates.contains(stringDate) {
                self.listOfDates.append(stringDate)
            }
        }
    }
    
    func populateListOfDatesAllLogs() {
        listOfDates = []
        for log in logs {
            let stringDate = formatDate(date: log.timeAdded.timeIntervalSince1970)
            if !self.listOfDates.contains(stringDate) {
                self.listOfDates.append(stringDate)
            }
        }
    }
    
    func populateDateLogMap() {
        dateLogMap = Dictionary(grouping: filteredLogs) { formatDate(date: $0.timeAdded.timeIntervalSince1970) }
    }
    
    func repopulateViewModel(movement: Movement) {
        filterLogsByMovement(movementId: movement.id)
        weightSelection = "All"
        weightSelectionEnum = .allSelected
        populateListOfWeights()
        populateListOfDates()
        populateDateLogMap()
    }
    
    func convertWeightDoubleToString(_ weight: Double) -> String {
        return weight.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", weight) : String(format: "%.1f", weight)
    }
    
    func formatDate(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
}
