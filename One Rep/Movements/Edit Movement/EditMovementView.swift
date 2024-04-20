//
//  EditMovementView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/3/24.
//

import SwiftUI
import RealmSwift

struct EditMovementView: View {
    
    @EnvironmentObject var theme: ThemeModel
    @ObservedRealmObject var movementModel: MovementViewModel
    
    @Binding var movement: Movement
    @State var newMovementName = ""
    private var isFormValid: Bool {
        !newMovementName.isEmpty && newMovementName != movement.name
    }
    
    @State private var newMuscleGroup = ""
    var muscles = [Muscles.Arms.description, Muscles.Back.description, Muscles.Chest.description, Muscles.Core.description, Muscles.Legs.description, Muscles.Shoulders.description]
    
    @State private var deleteConfirmedClicked = false
    @State private var showingDeleteMovementAlert = false
    
    func updateMovementInRealm() {
//        if let movement = movementViewModel[0].movements.first(where: {$0.id == movement.id}) {
//            let realm = try! Realm()
//            try! realm.write {
//                movement.thaw()?.name = newMovementName
//                movement.thaw()?.muscleGroup = newMuscleGroup
//            }
//        }
    }
    
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
                    MovementNameTextField(text: movement.name, movementName: $newMovementName, focus: false)
                }
                .padding(.horizontal, 16)
                
                VStack(alignment: .leading,  spacing: 4) {
                    Text("Edit muscle group")
                        .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                        .foregroundColor(.secondary)
                    MusclePicker(muscles: muscles, muscleGroup: $newMuscleGroup)
                }
                .padding(.horizontal, 16)
                
                HStack(spacing: 32) {
                    DeleteMovementButton(deleteConfirmedClicked: $deleteConfirmedClicked, showingDeleteMovementAlert: $showingDeleteMovementAlert)
                    UpdateMovementButton(isFormValid: isFormValid, updateMovementInRealm: { self.updateMovementInRealm() })
                }
            }
            .padding(.top, 36)
        }
        .onAppear {
            newMovementName = movement.name
            newMuscleGroup = movement.muscleGroup
        }
    }
}
