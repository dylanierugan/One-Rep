//
//  ResultHandler.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/28/24.
//

import Foundation
import SwiftUI

enum FirebaseResult {
    case success
    case failure(Error)
}

class ResultHandler: ObservableObject {
    
    func handleFetchDataResult(result: FirebaseResult?, loadingState: inout Bool, errorMessage: String) {
        guard let result = result else { return }
        switch result {
        case .success:
            loadingState = false
        case .failure(_):
            print(errorMessage)
        }
    }
    
    func handleResultDismiss(result: FirebaseResult?, dismiss: DismissAction, errorMessage: String) {
        guard let result = result else { return }
        switch result {
        case .success:
            dismiss()
        case .failure(_):
            print(errorMessage)
        }
    }
    
    func handleResultLogSet(result: FirebaseResult?, errorMessage: String) {
        guard let result = result else { return }
        switch result {
        case .success:
            return
        case .failure(_):
            print(errorMessage)
        }
    }
    
}
