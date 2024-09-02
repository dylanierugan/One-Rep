//
//  UserViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/14/24.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var userId: String = ""
    @Published var bodyweightEntries: [BodyweightEntry] = []
    
    @Published var userLoading = true
    
    private let networkManager = UserNetworkManager()
    
    // MARK: - Functions
    
    func subscribeToUser() {
        networkManager.subscribeToUser(userId: userId) { [weak self] bodyweightEntries, error in
            if let error = error {
                /// Todo - Error handle
                print("Error subscribing to user: \(error.localizedDescription)")
                return
            }
            self?.bodyweightEntries = bodyweightEntries ?? []
            self?.userLoading = false
        }
    }
    
    func addBodyweight(_ bodyweight: BodyweightEntry) async -> FirebaseResult {
        return await networkManager.addBodyweight(bodyweight)
    }
    
    func deleteBodyweight(docId: String) async -> FirebaseResult {
        return await networkManager.deleteBodyweight(docId: docId)
    }
    
    func deleteAllUserBodyweightEntries() async -> [FirebaseResult] {
        return await networkManager.deleteAllUserBodyweightEntries(for: userId, bodyweightEntries: bodyweightEntries)
    }
    
    func unsubscribe() {
        networkManager.unsubscribe()
    }
    
    func clearData() {
        bodyweightEntries = []
    }
    
    deinit {
        Task {
            await self.unsubscribe()
        }
    }
}
