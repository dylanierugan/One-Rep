//
//  LogController.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/23/24.
//

import Foundation
import RealmSwift

class LogController: ObservableObject {
        
    @Published var reps: Int = 0
    @Published var weight: Double = 0
    @Published var repsStr = ""
    @Published var weightStr = ""
    
    @Published var lastLog: Log? = nil
    
    // MARK: - Functions (Weight)
    
    /// Set weight and rep fields to most recent log
    func setMostRecentLog(_ logs: List<Log>, weightSelection: String) {
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
    
    func mutateWeight(_ mutatingValue: Double) {
        if weight + mutatingValue >= 0 && weight + mutatingValue <= 999 {
            weight += mutatingValue
            updateWeightString()
        }
    }
    
    func bindWeightValues() {
        if weightStr.isEmpty {
            weight = 0.0
        } else if let value = Double(weightStr) {
            weight = value
            updateWeightString()
        } else {
            weightStr = formatWeightString(weight)
        }
    }
    
    func updateWeightString() {
        weightStr = formatWeightString(weight)
    }
    
    func formatWeightString(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
    
    func limitWeightText(_ upper: Int) {
        if weightStr.count > upper {
            weightStr = String(weightStr.prefix(upper))
        }
    }
    
    // MARK: - Functions (Weight)
    
    func mutateReps(_ mutatingValue: Int) {
        if reps > 0 || reps < 999 {
            reps += mutatingValue
            repsStr = String(reps)
        }
    }
    
    func bindRepValues() {
        if repsStr.isEmpty {
            reps = 0
        } else if let value = Int(repsStr) {
            reps = value
        } else {
            repsStr = String(reps)
        }
    }
    
    func limitRepsText(_ upper: Int) {
        if repsStr.count > upper {
            repsStr = String(repsStr.prefix(upper))
        }
    }
}
