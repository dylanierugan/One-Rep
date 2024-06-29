//
//  LogController.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/23/24.
//

import Foundation

class LogController: ObservableObject {
    
    // MARK: - Variables
    
    @Published var reps: Int = 0
    @Published var weight: Double = 0
    @Published var repsStr = ""
    @Published var weightStr = ""
    
    @Published var lastLog: Log? = nil
    
    // MARK: - Functions (Weight)
    
    /// Set weight and rep fields to most recent log
    func setMostRecentLog(_ logs: [Log], weightSelection: String) {
        var sortedLogs = logs.sorted(by: { $0.timeAdded > $1.timeAdded })
        if weightSelection != "All" {
            let selectedWeight = Double(weightSelection) ?? 0.0
            sortedLogs = sortedLogs.filter { $0.weight == selectedWeight }
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
            weightStr = weight.clean
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

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension NumberFormatter {
    static var noDecimalUnlessNeeded: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1 /// You can set this to a reasonable number for your use case
        return formatter
    }
}
