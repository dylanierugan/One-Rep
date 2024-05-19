//
//  LogDataViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/12/24.
//

import Foundation
import RealmSwift

class LogDataViewModel: ObservableObject {
    
    // MARK: - Variables
    
    @Published var lastLog: Log? = nil
    
    @Published var listOfWeights = [String]()
    @Published var listOfDates = [String]()
    @Published var dateLogMap = [String: [Log]]()
    @Published var dateMovementLogMap = [String: [Movement:[Log]]]()
    
    @Published var reps: Int = 12
    @Published var repsStr = "12"
    @Published var weight: Double = 135
    @Published var weightStr = "135"
    @Published var weightSelection = "All"
    
    // MARK: - Functions
    
    /// Format date for section header Ex. Apr 24, 2024
    func formatDate(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    /// Populate listOfDates with unique dates and sort
    func populateListOfDates(_ logs: List<Log>) {
        listOfDates = []
        for log in logs {
            let stringDate = formatDate(date: log.date)
            if !self.listOfDates.contains(stringDate) {
                self.listOfDates.append(stringDate)
            }
        }
    }
    
    /// Populate list of weights with all unique weights
    func populateListOfWeights(_ logs: List<Log>) {
        listOfWeights = []
        for log in logs {
            let weight = convertWeightDoubleToString(log.weight)
            if !listOfWeights.contains(weight) {
                listOfWeights.append(weight)
            }
        }
        listOfWeights.sort{$0.localizedStandardCompare($1) == .orderedAscending}
        listOfWeights.insert("All", at: 0)
    }
    
    /// Populate logsByDate where the key = date and val = array of logs
    func populateDateLogMap(_ logs: List<Log>) {
        dateLogMap = [:]
        for date in self.listOfDates { /// Create all dict keys with empty lists
            self.dateLogMap[date] = []
        }
        for log in logs {
            let stringDate = formatDate(date: log.date)
            if self.listOfDates.contains(stringDate) {
                self.dateLogMap[stringDate]?.append(log)
            }
        }
    }
    
    /// Populate dateMovementLogMap where the each key is a uniqeue date that holds another map of movements and their logs on that date
    func populateDateMovementLogMap(_ logs: List<Log>) {
        dateMovementLogMap = [String: [Movement:[Log]]]()
        for date in self.listOfDates { /// Create all dict keys with empty lists
            self.dateMovementLogMap[date] = [Movement:[Log]]()
        }
        for log in logs {
            let stringDate = formatDate(date: log.date)
            if dateMovementLogMap[stringDate] != nil {
                dateMovementLogMap[stringDate]?[log.movement!, default: []].append(log)
            }
        }
    }
    
    /// Populate data based on filter for weight
    func filterWeightAndPopulateData(_ logs: List<Log>) {
        let filteredLogs = List<Log>()
        if weightSelection != "All" {
            let weight = (weightSelection as NSString).doubleValue
            for log in logs where log.weight == weight {
                filteredLogs.append(log)
            }
        } else {
            filteredLogs.append(objectsIn: logs)
        }
        let sortedFilteredLogs = filteredLogs.sorted(by: { $0.date > $1.date })
        let realmList = List<Log>()
        realmList.append(objectsIn: sortedFilteredLogs)
        populateListOfDates(realmList)
        populateDateLogMap(realmList)
    }
    
    /// Set weight and rep fields to most recent log
    func setMostRecentLog(_ logs: List<Log>) {
        var logs = logs.sorted(by: \Log.date, ascending: false)
        if weightSelection != "All" {
            logs = logs.sorted(by: \Log.date, ascending: false).where {
                ($0.weight == Double(weightSelection) ?? 0)
            }
        }
        lastLog = logs.first
        reps = lastLog?.reps ?? 12
        repsStr = String(lastLog?.reps ?? 12)
        weight = lastLog?.weight ?? 135
        weightStr = String(lastLog?.weight ?? 135)
    }
    
    /// Take float and convert to 0 or 1 decimal string
    func convertWeightDoubleToString(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
    
    func getAllLogs(_ movements: List<Movement>) -> List<Log> {
        let allLogs = List<Log>()
        for movement in movements {
            for log in movement.logs {
                allLogs.append(log)
            }
        }
        return allLogs
    }
}
