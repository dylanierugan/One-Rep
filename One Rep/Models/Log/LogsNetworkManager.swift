//
//  LogsNetworkManager.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/1/24.
//

import Foundation
import FirebaseFirestore

class LogsNetworkManager {
    
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    func getLogsAddSnapshot(userId: String, completion: @escaping ([Log]?, Error?) -> Void) {
        db.collection(FirebaseCollection.LogsCollection.rawValue)
            .whereField(LogAttributes.UserId.rawValue, isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let querySnapshot = querySnapshot else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found"])
                    completion(nil, error)
                    return
                }
                let logs = querySnapshot.documents.compactMap { document -> Log? in
                    let docId = document.documentID
                    let movementId = document[LogAttributes.MovementId.rawValue] as? String ?? ""
                    let reps = document[LogAttributes.Reps.rawValue] as? Int ?? 0
                    let weight = document[LogAttributes.Weight.rawValue] as? Double ?? 0
                    let bodyweight = document[LogAttributes.Bodyweight.rawValue] as? Double ?? 0
                    let isBodyWeight = document[LogAttributes.IsBodyWeight.rawValue] as? Bool ?? false
                    let timeAdded = document[LogAttributes.TimeAdded.rawValue] as? Double ?? 0
                    let unitString = document[LogAttributes.Unit.rawValue] as? String ?? ""
                    let unit = UnitSelection(rawValue: unitString) ?? UnitSelection.lbs
                    return Log(id: docId, userId: userId, movementId: movementId, reps: reps, weight: weight, bodyweight: bodyweight, isBodyWeight: isBodyWeight, timeAdded: timeAdded, unit: unit, index: 0)
                }
                completion(logs, nil)
            }
    }

    func addLog(_ log: Log) async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.LogsCollection.rawValue).document(log.id).setData(from: log)
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    func updateLog(_ log: Log) async -> FirebaseResult {
        do {
            try db.collection(FirebaseCollection.LogsCollection.rawValue).document(log.id).setData(from: log)
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    func deleteLog(docId: String) async -> FirebaseResult {
        do {
            try await db.collection(FirebaseCollection.LogsCollection.rawValue).document(docId).delete()
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    func deleteAllMovementLogs(movementId: String, logs: [Log]) async -> FirebaseResult {
        let logsToDelete = logs.filter { $0.movementId == movementId }
        for log in logsToDelete {
            do {
                try await db.collection(FirebaseCollection.LogsCollection.rawValue).document(log.id).delete()
            } catch {
                return .failure(error)
            }
        }
        return .success
    }
    
    func deleteAllUserLogs(userId: String, logs: [Log]) async -> [FirebaseResult] {
        var results = [FirebaseResult]()
        for log in logs {
            if log.userId == userId {
                let result = await deleteLog(docId: log.id)
                results.append(result)
            }
        }
        return results
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
}
