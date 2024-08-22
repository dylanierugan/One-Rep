//
//  ErrorHandler.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/6/24.
//

import Foundation
import SwiftUI

enum FirebaseResult {
    case success
    case failure(Error)
}

class ErrorHandler: ObservableObject {
    
    // MARK: - Properties
    
    @Published var error: Error? {
        didSet {
            self.showError = error != nil
        }
    }
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK: - Internal Functions
    
    private func handleFailure() {
        withAnimation {
            self.showError = true
            self.errorMessage = errorMessage
        }
    }
    
    private func resetErrorProperties() {
        withAnimation {
            self.showError = false
            self.errorMessage = ""
        }
    }
    
    // MARK: - Generic Function
    
    func handleResult(result: FirebaseResult?) {
        guard let result = result else { return }
        switch result {
        case .success:
            return
        case .failure(_):
            handleFailure()
        }
    }
    
    // MARK: - Movement Functions
    
    func handleMovementUpdate(result: FirebaseResult?, dismiss: DismissAction) {
        guard let result = result else { return }
        switch result {
        case .success:
            dismiss()
        case .failure(_):
            handleFailure()
        }
    }
    
    // MARK: - Routine Functions
    
    func handleAddRoutine(result: FirebaseResult?, dismiss: DismissAction, dismissBothViews: inout Bool) {
        guard let result = result else { return }
        switch result {
        case .success:
            dismissBothViews = true
            dismiss()
        case .failure(_):
            handleFailure()
        }
    }
    
    func handleUpdateRoutine(result: FirebaseResult?, dismiss: DismissAction?) {
        guard let result = result else { return }
        switch result {
        case .success:
            if let dismiss {
                dismiss()
            }
        case .failure(_):
            handleFailure()
        }
    }
    
    // MARK: - Bodyweight Functions
    
    func handleAddBodyweight(result: FirebaseResult?, dismiss: DismissAction) {
        guard let result = result else { return }
        switch result {
        case .success:
            dismiss()
        case .failure(_):
            handleFailure()
        }
    }
    
    // MARK: - Log Functions
    
    func handleUpdateLog(result: FirebaseResult?, logsViewModel: LogsViewModel, logController: LogController, movement: Movement) {
        guard let result = result else { return }
        switch result {
        case .success:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if logsViewModel.weightSelection == WeightSelection.All.rawValue  {
                    logsViewModel.repopulateViewModel(weightSelection: WeightSelection.All.rawValue , movement: movement)
                } else {
                    logsViewModel.repopulateViewModel(weightSelection: logController.editWeightStr, movement: movement)
                }
                logController.setMostRecentLog(logsViewModel.filteredLogs, weightSelection: logsViewModel.weightSelection, isBodyweight: movement.movementType == .Bodyweight ? true : false)
            }
            return
        case .failure(_):
            handleFailure()
        }
    }

    @MainActor
    func handleDeleteLog(result: FirebaseResult?, logsViewModel: LogsViewModel, logController: LogController, movement: Movement) {
        guard let result = result else { return }
        switch result {
        case .success:
            if logsViewModel.checkIfWeightDeleted(movementId: movement.id, weightSelection: logsViewModel.weightSelection) {
                logsViewModel.repopulateViewModel(weightSelection: WeightSelection.All.rawValue, movement: movement)
            } else {
                logsViewModel.repopulateViewModel(weightSelection: logsViewModel.weightSelection, movement: movement)
            }
            logController.setMostRecentLog(logsViewModel.filteredLogs, weightSelection: logsViewModel.weightSelection, isBodyweight: movement.movementType == .Bodyweight ? true : false)
        case .failure(_):
            handleFailure()
        }
    }
    
    @MainActor
    func handleLogSet(result: FirebaseResult?, logsViewModel: LogsViewModel, logController: LogController, movement: Movement) {
        guard let result = result else { return }
        switch result {
        case .success:
            if logsViewModel.weightSelection != WeightSelection.All.rawValue  {
                logsViewModel.repopulateViewModel(weightSelection: logController.weightStr, movement: movement)
            } else {
                logsViewModel.repopulateViewModel(weightSelection: WeightSelection.All.rawValue , movement: movement)
            }
            logController.setMostRecentLog(logsViewModel.filteredLogs, weightSelection: logsViewModel.weightSelection, isBodyweight: movement.movementType == .Bodyweight ? true : false)
            return
        case .failure(_):
            handleFailure()
        }
    }
}
