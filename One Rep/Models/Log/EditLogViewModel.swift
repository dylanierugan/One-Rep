//
//  EditLogViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/22/24.
//

import Foundation

class EditLogViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var editReps: Int = 0
    @Published var editRepsStr = ""
    
    @Published var editWeight: Double = 0
    @Published var editWeightStr = ""
    
    @Published var editBodyweight: Double = 0
    
    @Published var addWeightToBodyweight: Bool = false
    
    init(lastLog: Log) {
        editReps = lastLog.reps
        editRepsStr = String(lastLog.reps)
        editWeight = lastLog.weight
        editWeightStr = String(lastLog.weight)
    }
    
    // MARK: - Functions
    
    func mutateEditWeight(_ mutatingValue: Double) {
        if editWeight + mutatingValue >= 0 && editWeight + mutatingValue <= 999 {
            editWeight += mutatingValue
            editWeightStr = editWeight.clean
        }
    }
    
    func mutateEditReps(_ mutatingValue: Int) {
        if editReps > 0 || editReps < 999 {
            editReps += mutatingValue
            editRepsStr = String(editReps)
        }
    }
    
    func bindEditRepValues() {
        if editRepsStr.isEmpty {
            editReps = 0
        } else if let value = Int(editRepsStr) {
            editReps = value
        } else {
            editRepsStr = String(editReps)
        }
    }
    
    func limitEditRepsText(_ upper: Int) {
        if editRepsStr.count > upper {
            editRepsStr = String(editRepsStr.prefix(upper))
        }
    }
}
