//
//  LogsNetworkManager.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/1/24.
//

import Foundation
import FirebaseFirestore

class LogsNetworkManager {
    
    static let shared = LogsNetworkManager()
    
    // MARK: - Properties
    
    private let userCollection: CollectionReference = Firestore.firestore().collection(FirebaseCollection.UserCollection.rawValue)
    
    private func userDocument(userId: String) -> DocumentReference {
        return userCollection.document(userId)
    }
    
    private func movementCollection(userId: String) -> CollectionReference {
        return userDocument(userId: userId).collection(FirebaseCollection.MovementCollection.rawValue)
    }
    
    private func userMovementDocument(userId: String, movementId: String) -> DocumentReference {
        return movementCollection(userId: userId).document(movementId)
    }
    
    private func movementLogsCollection(userId: String, movementId: String) -> CollectionReference {
        return userMovementDocument(userId: userId, movementId: movementId).collection(FirebaseCollection.LogsCollection.rawValue)
    }
    
    private func movementLogDocument(userId: String, movementId: String, logId: String) -> DocumentReference {
        return movementLogsCollection(userId: userId, movementId: movementId).document(logId)
    }
    
    // MARK: - Functions
    
    func getLogs(userId: String, movements: [Movement]) async throws -> [Log] {
        var logs: [Log] = []
        for movement in movements {
            let snapshot = try await movementLogsCollection(userId: userId, movementId: movement.id).getDocuments(as: Log.self)
            for document in snapshot {
                logs.append(document)
            }
        }
        return logs
    }
    
    func addLog(userId: String, movement: Movement, logViewModel: LogViewModel, userViewModel: UserViewModel, unit: UnitSelection) async throws -> Log {
        let document = movementLogsCollection(userId: userId, movementId: movement.id).document()
        let newLog = await createAndReturnLog(userId: userId, docId: document.documentID, movement: movement, logViewModel: logViewModel, userViewModel: userViewModel, unit: unit)
        let data: [String:Any] = [
            Log.CodingKeys.id.rawValue : newLog.id,
            Log.CodingKeys.userId.rawValue : userId,
            Log.CodingKeys.movementId.rawValue: movement.id,
            Log.CodingKeys.reps.rawValue : newLog.reps,
            Log.CodingKeys.weight.rawValue : newLog.weight,
            Log.CodingKeys.bodyweight.rawValue : newLog.bodyweight,
            Log.CodingKeys.isBodyWeight.rawValue : newLog.isBodyWeight,
            Log.CodingKeys.timeAdded.rawValue : newLog.timeAdded,
            Log.CodingKeys.unit.rawValue : newLog.unit.rawValue
        ]
        try await document.setData(data, merge: false)
        return newLog
    }
    
    @MainActor
    func createAndReturnLog(userId: String,
                           docId: String,
                           movement: Movement,
                           logViewModel: LogViewModel,
                           userViewModel: UserViewModel,
                           unit: UnitSelection) -> Log {
        var log = Log()
        if let bodyWeightEntry = userViewModel.bodyweightEntries.first {
            if (logViewModel.addWeightToBodyweight && movement.movementType == .Bodyweight) || movement.movementType == .Weight {
                log = Log(
                    id: docId,
                    userId: userId,
                    movementId: movement.id,
                    reps: logViewModel.reps,
                    weight: logViewModel.weight ?? 0,
                    bodyweight: bodyWeightEntry.bodyweight,
                    isBodyWeight: movement.movementType == .Bodyweight,
                    timeAdded: Date(),
                    unit: unit
                )
            } else if !logViewModel.addWeightToBodyweight && movement.movementType == .Bodyweight {
                log = Log(
                    id: docId,
                    userId: userId,
                    movementId: movement.id,
                    reps: logViewModel.reps,
                    weight: 0,
                    bodyweight: bodyWeightEntry.bodyweight,
                    isBodyWeight: movement.movementType == .Bodyweight,
                    timeAdded: Date(),
                    unit: unit)
            }
        } else {
            log = Log(
                id: docId,
                userId: userId,
                movementId: movement.id,
                reps: logViewModel.reps,
                weight: logViewModel.weight ?? 0,
                bodyweight: 0,
                isBodyWeight: movement.movementType == .Bodyweight,
                timeAdded: Date(),
                unit: unit)
        }
        return log
    }
    
    func updateLog(userId: String, movement: Movement, log: Log) async throws {
        let data: [String:Any] = [
            Log.CodingKeys.reps.rawValue : log.reps,
            Log.CodingKeys.weight.rawValue : log.weight,
            Log.CodingKeys.bodyweight.rawValue : log.bodyweight,
            Log.CodingKeys.unit.rawValue : log.unit.rawValue
        ]
        do {
            try await movementLogDocument(userId: userId, movementId: movement.id, logId: log.id).updateData(data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteLog(userId: String, movement: Movement, log: Log) async throws {
        try await movementLogDocument(userId: userId, movementId: movement.id, logId: log.id).delete()
    }
    
    func deleteAllMovementLogs(userId: String, movement: Movement, logs: [Log]) async throws {
        for log in logs {
            print(log)
            try await deleteLog(userId: userId, movement: movement, log: log)
        }
    }
    
    func deleteAllLogs(userId: String, movements: [Movement], logs: [Log]) async throws {
        for movement in movements {
            for log in logs {
                try await deleteLog(userId: userId, movement: movement, log: log)
            }
        }
    }
}
