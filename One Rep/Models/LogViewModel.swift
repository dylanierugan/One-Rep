//
//  LogViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/28/24.
//

import Foundation

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

enum LogAttributes: String {
    case UserId = "userId"
    case MovementId = "movementId"
    case Reps = "reps"
    case Weight = "weight"
    case IsBodyWeight = "isBodyWeight"
    case TimeAdded = "timeAdded"
    case Unit = "unit"
}

@MainActor
class LogViewModel: ObservableObject {
    
    // MARK: - Variables
    
    let db = Firestore.firestore()
    
    @Published var userId: String = ""
    @Published var logs = [Log]()
    
    @Published var filteredLogs = [Log]()
    @Published var weightSelection = WeightSelection.All.rawValue
    @Published var listOfWeights = [String]()
    @Published var weightLogMap = [String: [Log]]()
    @Published var listOfDates = [String]()
    @Published var dateLogMap = [String: [Log]]()
    
    @Published var unit: UnitSelection = .lbs
    
    // MARK: - Data functions
    
    /// Filter logs for the movementId
    func filterLogs(movementId: String) {
        self.filteredLogs = []
        self.filteredLogs = logs.filter { $0.movementId == movementId }
    }
    
    /// Populate list of weights with all unique weights
    func populateListOfWeights() {
        listOfWeights = []
        for log in filteredLogs {
            let weight = convertWeightDoubleToString(log.weight)
            if !listOfWeights.contains(weight) {
                listOfWeights.append(weight)
            }
        }
        listOfWeights.sort{$0.localizedStandardCompare($1) == .orderedAscending}
        listOfWeights.insert(WeightSelection.All.rawValue , at: 0)
    }
    
    func populateWeightLogMap() {
        weightLogMap = [:]
        for log in filteredLogs {
            let weightString = convertWeightDoubleToString(log.weight)
            if weightLogMap[weightString] != nil {
                weightLogMap[weightString]?.append(log)
            } else {
                weightLogMap[weightString] = [log]
            }
        }
    }
    
    func checkIfWeightDeleted(movementId: String, weightSelection: String) -> Bool {
        self.filterLogs(movementId: movementId)
        self.populateWeightLogMap()
        if self.weightLogMap[weightSelection] == nil {
            return true
        } else {
            return false
        }
    }
    
    /// Populate data based on filter for weight
    func filterWeightAndPopulateData(movementId: String) {
        filteredLogs = []
        filterLogs(movementId: movementId)
        if weightSelection != WeightSelection.All.rawValue {
            let weight = (weightSelection as NSString).doubleValue
            self.filteredLogs = filteredLogs.filter { $0.weight == weight }
        }
        self.filteredLogs = filteredLogs.sorted(by: { $0.timeAdded > $1.timeAdded })
    }
    
    /// Populate listOfDates with unique dates and sort
    func populateListOfDates() {
        listOfDates = []
        for log in filteredLogs {
            let stringDate = formatDate(date: log.timeAdded)
            if !self.listOfDates.contains(stringDate) {
                self.listOfDates.append(stringDate)
            }
        }
    }
    
    /// Populate logsByDate where the key = date and val = array of logs
    func populateDateLogMap() {
        dateLogMap = [:]
        for date in self.listOfDates { /// Create all dict keys with empty lists
            self.dateLogMap[date] = []
        }
        for log in filteredLogs {
            let stringDate = formatDate(date: log.timeAdded)
            if self.listOfDates.contains(stringDate) {
                self.dateLogMap[stringDate]?.append(log)
            }
        }
    }
    
    func repopulateViewModel(weightSelection: String, movement: Movement) {
            self.weightSelection = weightSelection
            self.filterLogs(movementId: movement.id)
            self.populateListOfWeights()
            self.filterWeightAndPopulateData(movementId: movement.id)
            self.populateListOfDates()
            self.populateDateLogMap()
    }
    
    // MARK: - Data formatting/converting
    
    /// Take float and convert to 0 or 1 decimal string
    func convertWeightDoubleToString(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
    
    /// Format date for section header Ex. Apr 24, 2024
    func formatDate(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    // MARK: - Firebase functions
    
    func getLogsAddSnapshot(completion: @escaping (FirebaseResult) -> Void) {
        db.collection(FirebaseCollection.LogsCollection.rawValue)
            .whereField(LogAttributes.UserId.rawValue, isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let querySnapshot = querySnapshot else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: ""])
                    completion(.failure(error))
                    return
                }
                self.logs = []
                for document in querySnapshot.documents {
                    let docId = document.documentID
                    let movementId = document[LogAttributes.MovementId.rawValue] as? String ?? ""
                    let reps = document[LogAttributes.Reps.rawValue] as? Int ?? 0
                    let weight = document[LogAttributes.Weight.rawValue] as? Double ?? 0
                    let isBodyWeight = document[LogAttributes.IsBodyWeight.rawValue] as? Bool ?? false
                    let timeAdded = document[LogAttributes.TimeAdded.rawValue] as? Double ?? 0
                    let unitString = document[LogAttributes.Unit.rawValue] as? String ?? ""
                    let unit = UnitSelection(rawValue: unitString) ?? UnitSelection.lbs
                    let log = Log(id: docId, userId: self.userId, movementId: movementId, reps: reps, weight: weight, isBodyWeight: isBodyWeight, timeAdded: timeAdded, unit: unit, index: 0)
                    self.logs.append(log)
                }
                completion(.success)
            }
    }
    
    func addLog(log: Log) async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.LogsCollection.rawValue).document(log.id ).setData(from: log)
            self.logs.append(log)
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    func updateLog(log: Log) async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.LogsCollection.rawValue).document(log.id).setData(from: log)
            return .success
        }
        catch {
            return .failure(error)
        }
    }
    
    func deleteLog(docId: String) async -> FirebaseResult {
        do {
            try await db.collection(FirebaseCollection.LogsCollection.rawValue).document(docId).delete()
            return .success
        } catch {
            return .failure(error)
        }
    }
    
}
