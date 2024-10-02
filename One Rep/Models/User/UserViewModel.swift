//
//  UserViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/14/24.
//

import Combine
import Foundation
import FirebaseAuth

@MainActor
class UserViewModel: ObservableObject {
    
    // MARK: - Properties
    
    var userManager = UserManager()
    
    @Published var user: UserModel? = nil
    @Published var bodyweightEntries: [BodyweightEntry] = []
    
    @Published var userLoading = true
    @Published var bodyweightEntriesLoading = true
    
    var userId: String
    
    init(userId: String = "") {
        self.userId = userId
    }
    
    // MARK: - Functions
    
    func clearLocalBodyweightEntries() {
        bodyweightEntries = []
    }
    
    func loadCurrentUser() async {
        defer { userLoading = false }
        do {
            self.user = try await userManager.getUser(userId: userId)
        } catch {
            // TODO: Handle error
        }
    }
    
    func loadBodyweightEntries() async {
        do {
            bodyweightEntries = try await userManager.getBodyweightEntries(userId: userId)
        } catch {
            // TODO: Handle error
        }
    }
    
    func togglePremiumStatus() async {
        guard let user else { return }
        let currentValue = user.isPremium
        do {
            try await userManager.updateUserPremiumStatus(userId: userId, isPremium: !currentValue)
            self.user = try await userManager.getUser(userId: userId)
        } catch {
            // TODO: Handle error
        }
    }
    
    func addBodyweightEntry(bodyweight: Double) async -> BodyweightEntry? {
        do {
            return try await userManager.addUserBodyweight(userId: userId, bodyweight: bodyweight)
        } catch {
            // TODO: Error handle
        }
        return nil
    }
    
    func deleteBodyweight(bodyweightEntryId: String) async {
        Task {
            do {
                try await userManager.removeBodyweight(userId: userId,
                                                       bodyweightEntryId: bodyweightEntryId)
            } catch {
                // TODO: Handle error
            }
        }
    }
    
    func deleteAllBodyweightEntries() async {
        do {
            try await userManager.deleteAllBodyweightEntries(userId: userId)
        } catch {
            // TODO: Error handle
        }
    }
    
    func deleteUser() async {
        Task {
            do {
                try await userManager.deleteUser(userId: userId)
            } catch {
                // TODO: Handle error
            }
        }
    }
}
