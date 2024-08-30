//
//  ActivityViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/30/24.
//

import Foundation

class ActivityViewModel: ObservableObject {
    
    // MARK: - Variables
    
    @Published var logs: [Log]
    
    @Published var listOfDates = [String]()
    @Published var dateMovementLogMap = [String: [Movement:[Log]]]()
    
    // MARK: - Init
    
    init(logs: [Log]) {
        self.logs = logs
    }
    
    // MARK: - Functions
    
    /// Populate listOfDates with unique dates and sort
    func populateListOfDatesAllLogs() {
        listOfDates = []
        for log in logs {
            let stringDate = formatDate(date: log.timeAdded)
            if !self.listOfDates.contains(stringDate) {
                self.listOfDates.append(stringDate)
            }
        }
    }
    
    /// Populate dateMovementLogMap where the each key is a uniqeue date that holds another map of movements and their logs on that date
    func populateDateMovementLogMap(movements: [Movement]) {
        dateMovementLogMap = [String: [Movement:[Log]]]()
        /// Create all dict keys with empty lists
        for date in self.listOfDates {
            self.dateMovementLogMap[date] = [Movement:[Log]]()
        }
        for log in logs {
            let stringDate = formatDate(date: log.timeAdded)
            let movement = movements.first(where: {$0.id == log.movementId})
            if dateMovementLogMap[stringDate] != nil {
                if let movement = movement {
                    dateMovementLogMap[stringDate]?[movement, default: []].append(log)
                    dateMovementLogMap[stringDate]?[movement]?.sort(by: { $0.timeAdded < $1.timeAdded })
                }
            }
        }
    }
    
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
    
}
