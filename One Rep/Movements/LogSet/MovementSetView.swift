//
//  SetView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI
import RealmSwift

struct MovementSetView: View {
    
    @ObservedRealmObject var movementModel: MovementViewModel
    @EnvironmentObject var theme: ThemeModel
    
    @State var movement: Movement
    
    @State var reps: Int = 12
    @State var repsStr = "12"
    
    @State var weight: Double = 135
    @State var weightStr = "135"
    
    @State var setTypeSelection = "Working Set"
    @State var setTypeColor = Color("BlueLight")
    
    @State var bodyWeight = 185
    @State var isBodyWeightSelected = false
    
    @FocusState var isInputActive: Bool
    
    @State var showEditMovementPopup = false
    
    var body: some View {
        ZStack {
            Color(theme.BackgroundColor)
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .center, spacing: 16) {
                    HStack {
                        Spacer()
                        SetTypePicker(setTypeSelection: $setTypeSelection, setTypeColor: $setTypeColor)
                        Spacer()
                    }
                    HStack(spacing: 8) {
                        MutateWeightView(color: Color(setTypeColor), weight: $weight, weightStr: $weightStr, isInputActive: _isInputActive)
                        if setTypeSelection != "PR" {
                            Spacer()
                            MutateRepsView(color: Color(setTypeColor), reps: $reps, repsStr: $repsStr, isInputActive: _isInputActive)
                        }
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isInputActive = false
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    LogSetButton(setTypeSelection: $setTypeSelection, setTypeColor: $setTypeColor)
                        .padding(.top, 8)
                }
                .padding(.vertical, 24)
                .background(Color(Colors.BackgroundElementColor.description))
                Divider()
                    .frame(height: 1.5)
                    .padding(.top, -8)
                Spacer()
            }
            .sheet(isPresented: $showEditMovementPopup) {
                EditMovementView(movementModel: movementModel, movement: $movement)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditMovementButton(showEditMovementPopup: $showEditMovementPopup)
                }
                ToolbarItem(placement: .principal) {
                    HStack {
                        MuscleCircleIcon(movement: movement, size: 32, font: .caption2.weight(.regular))
                        Text(movement.name)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
