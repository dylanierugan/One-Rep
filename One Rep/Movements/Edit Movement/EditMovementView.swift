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
    
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.realm) var realm
    
    @ObservedRealmObject var movement: Movement
    @ObservedRealmObject var movementModel: MovementViewModel
    
    @State private var newMovementName = ""
    @State private var newMuscleGroup: MuscleType = .Arms
    @State private var deleteConfirmedClicked = false
    @State private var showingDeleteMovementAlert = false
    
    @Binding var showDoneToolBar: Bool
    
    var muscleGroups: [MuscleType] = [.All, .Arms, .Back, .Chest, .Core, .Legs, .Shoulders]
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.BackgroundColor)
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
                
                HStack(spacing: 32) {
                    DeleteMovementButton(deleteConfirmedClicked: $deleteConfirmedClicked, showingDeleteMovementAlert: $showingDeleteMovementAlert, deleteMovementInRealm: { self.deleteMovementInRealm() })
                    UpdateMovementButton(updateMovementInRealm: { self.updateMovementInRealm() })
                }
            }
            .padding(.vertical, 24)
        }
        .onAppear {
            newMovementName = movement.name
            newMuscleGroup = movement.muscleGroup
        }
        .onDisappear {
            showDoneToolBar = true
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
                    realm.delete(thawedMovement)
                }
            } catch  {
                /// Handle error
            }
        }
    }
}
