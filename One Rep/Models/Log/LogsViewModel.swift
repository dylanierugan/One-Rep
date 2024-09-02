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
    @Published var weightSelection = WeightSelection.All.rawValue
    @Published var listOfWeights = [String]()
    @Published var weightLogMap = [String: [Log]]()
    @Published var listOfDates = [String]()
    @Published var dateLogMap = [String: [Log]]()
    
    @Published var logsLoading = true
    
    @Published var unit: UnitSelection
    
    private let networkManager = LogsNetworkManager()
    
    // MARK: - Initializer
    
    init(unit: UnitSelection) {
        self.unit = unit
    }
    
    // MARK: - Data functions
    
    func clearData() {
        logs = []
    }
    
    func deleteAllUserLogs(userId: String) async -> [FirebaseResult] {
        return await networkManager.deleteAllUserLogs(userId: userId, logs: logs)
    }
    
    func filterLogs(movementId: String) {
        filteredLogs = logs.filter { $0.movementId == movementId }
    }
    
    func populateListOfWeights() {
        listOfWeights = Array(Set(filteredLogs.map { convertWeightDoubleToString($0.weight) }))
        listOfWeights.sort { $0.localizedStandardCompare($1) == .orderedAscending }
        listOfWeights.insert(WeightSelection.All.rawValue, at: 0)
    }
    
    func populateWeightLogMap() {
        weightLogMap = Dictionary(grouping: filteredLogs) { convertWeightDoubleToString($0.weight) }
    }
    
    func checkIfWeightDeleted(movementId: String, weightSelection: String) -> Bool {
        filterLogs(movementId: movementId)
        populateWeightLogMap()
        return weightLogMap[weightSelection] == nil
    }
    
    func filterWeightAndPopulateData(movementId: String) {
        filterLogs(movementId: movementId)
        if weightSelection != WeightSelection.All.rawValue {
            let weight = (weightSelection as NSString).doubleValue
            filteredLogs = filteredLogs.filter { $0.weight == weight }
        }
        filteredLogs.sort { $0.timeAdded > $1.timeAdded }
    }
    
    func populateListOfDates() {
        listOfDates = Array(Set(filteredLogs.map { formatDate(date: $0.timeAdded) }))
    }
    
    func populateListOfDatesAllLogs() {
        listOfDates = Array(Set(logs.map { formatDate(date: $0.timeAdded) }))
    }
    
    func populateDateLogMap() {
        dateLogMap = Dictionary(grouping: filteredLogs) { formatDate(date: $0.timeAdded) }
    }
    
    func repopulateViewModel(weightSelection: String, movement: Movement) {
        self.weightSelection = weightSelection
        filterLogs(movementId: movement.id)
        populateListOfWeights()
        filterWeightAndPopulateData(movementId: movement.id)
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
    
    // MARK: - Firebase functions
    
    func unsubscribe() {
        networkManager.unsubscribe()
    }
    
    func getLogsAddSnapshot(userId: String) {
        networkManager.getLogsAddSnapshot(userId: userId) { [weak self] logs, error in
            if let error = error {
                print("Error getting logs: \(error.localizedDescription)")
                return
            }
            self?.logs = logs ?? []
            self?.logsLoading = false
        }
    }
    
    func addLog(_ log: Log) async -> FirebaseResult {
        let result = await networkManager.addLog(log)
        if case .success = result {
            logs.append(log)
        }
        return result
    }
    
    func updateLog(_ log: Log) async -> FirebaseResult {
        return await networkManager.updateLog(log)
    }
    
    func deleteLog(docId: String) async -> FirebaseResult {
        return await networkManager.deleteLog(docId: docId)
    }
    
    func deleteAllMovementLogs(movementId: String) async -> FirebaseResult {
        return await networkManager.deleteAllMovementLogs(movementId: movementId, logs: logs)
    }
    
    deinit {
        Task {
            await self.unsubscribe()
        }
    }
}
