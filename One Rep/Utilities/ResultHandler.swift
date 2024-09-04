//
//  ResultHandler.swift
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

class ResultHandler: ObservableObject {
    
    // MARK: - Properties
    
    static var shared = ResultHandler()
    
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
    
    func handleResult(result: FirebaseResult?, onSuccess: @escaping () -> Void) {
        guard let result = result else { return }
        switch result {
        case .success:
            onSuccess()
        case .failure(let error):
            self.error = error
            handleFailure()
        }
    }
    
    func handleResult(result: FirebaseResult?, onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        guard let result = result else { return }
        switch result {
        case .success:
            onSuccess()
        case .failure(let error):
            self.error = error
            handleFailure()
            onFailure(error)
        }
    }
    
//    errorHandler.handleResult(result: someResult, onSuccess: {
//        // Success action, e.g., dismiss the view
//        dismiss()
//    }, onFailure: { error in
//        // Failure action, e.g., log the error, show a specific message, etc.
//        print("Operation failed with error: \(error.localizedDescription)")
//    })

}
