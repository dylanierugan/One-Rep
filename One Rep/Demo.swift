//
//  Home.swift
//  GlassMorphismNew
//
//  Created by Dylan Ierugan on 4/4/24
//

import Combine
import SwiftUI
import RealmSwift

struct Demo: View {
    
    @Environment(\.realm) var realm
    
    @State var routine = Routine()
    @ObservedRealmObject var routineViewModel: RoutineViewModel
    @ObservedRealmObject var movementViewModel: MovementViewModel
    
    var body: some View {
        VStack {
            
            Button {
                self.routine = Routine(name: "Test Routine", icon: Icons.Bench.description, timeAdded: 0)
                let movements = movementViewModel.movements
                for movement in movements {
                    let managedMovement: Movement
                    if let existingMovement = realm.object(ofType: Movement.self, forPrimaryKey: movement.id) {
                        managedMovement = existingMovement
                    } else {
                        try! realm.write {
                            realm.add(movement, update: .all)
                        }
                        managedMovement = movement
                    }
                    routine.movements.append(managedMovement)
                }
                $routineViewModel.routines.append(routine)
            } label: {
                Text("Create Routine")
                    .foregroundStyle(.lightGreen)
            }
            
            if let routine = routineViewModel.routines.first {
                Text(routine.name)
                ForEach(routine.movements) { movement in
                    Text(movement.name)
                }
            }
            
            Button {
                if let thawedRoutine = routine.thaw() {
                    do {
                        try realm.write {
                            thawedRoutine.name = "Name Changed"
                        }
                    } catch  {
                        /// Handle error
                    }
                }
            } label: {
                Text("Edit Routine")
                    .foregroundStyle(.lightGreen)
            }
            
            Button {
                if let thawedRoutine = routine.thaw() {
                    do {
                        try realm.write {
                            realm.delete(thawedRoutine)
                        }
                    } catch  {
                        /// Handle error
                    }
                }
            } label: {
                Text("Delete Routine")
                    .foregroundStyle(.lightGreen)
            }
            
        }
    }
}


//#Preview {
//    Demo()
//}
