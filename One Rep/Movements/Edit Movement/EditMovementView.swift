//
//  EditMovementView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/3/24.
//

import SwiftUI
import RealmSwift

struct EditMovementView: View {
    
    // MARK: - Variables
    
    @Environment(\.realm) var realm
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var movement: Movement
    @ObservedRealmObject var movementViewModel: MovementViewModel
    
    @State private var newMovementName = ""
    @State private var newMuscleGroup: MuscleType = .Arms
    @State private var deleteConfirmedClicked = false
    @State private var showingDeleteMovementAlert = false
    
    @Binding var showDoneToolBar: Bool
    
    var muscleGroups: [MuscleType] = [.All, .Arms, .Back, .Chest, .Core, .Legs, .Shoulders]
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                
                VStack(spacing: 36) {
                    
                    Text("Edit Movement")
                        .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Edit name")
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MovementNameTextField(focus: false, movementName: $newMovementName, text: movement.name)
                    }
                    .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading,  spacing: 4) {
                        Text("Edit muscle group")
                            .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                            .foregroundColor(.secondary)
                        MusclePicker(muscleGroup: $newMuscleGroup)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 24)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        DeleteMovementButton(deleteConfirmedClicked: $deleteConfirmedClicked, showingDeleteMovementAlert: $showingDeleteMovementAlert, deleteMovementInRealm: { self.deleteMovementInRealm() })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        UpdateMovementButton(updateMovementInRealm: { self.updateMovementInRealm() })
                    }
                })
            }
            .onAppear {
                newMovementName = movement.name
                newMuscleGroup = movement.muscleGroup
            }
            .onDisappear {
                showDoneToolBar = true
            }
        }
    }
    
    // MARK: - Functions
    
    func updateMovementInRealm() {
        if let thawedMovement = movement.thaw() {
            do {
                try realm.write {
                    thawedMovement.name = newMovementName
                    thawedMovement.muscleGroup = newMuscleGroup
                }
            } catch  {
                /// Handle error
            }
        }
    }
    
    func deleteMovementInRealm() {
        if let thawedMovement = movement.thaw() {
            do {
                try realm.write {
                    realm.delete(thawedMovement.logs)
                    realm.delete(thawedMovement)
                }
            } catch  {
                /// Handle error
            }
        }
    }
}
