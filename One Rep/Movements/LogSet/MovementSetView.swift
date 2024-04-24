//
//  SetView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI
import RealmSwift

struct MovementSetView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var movementModel: MovementViewModel
    @ObservedRealmObject var movement: Movement
    
    @State private var reps: Int = 12
    @State private var repsStr = "12"
    @State private var weight: Double = 135
    @State private var weightStr = "135"
    @State private var setTypeSelection = "Working Set"
    @State private var setTypeColorDark = Color(Colors.DarkBlue.description)
    @State private var setTypeColorLight = Color(Colors.LightBlue.description)
    @State private var isBodyWeightSelected = false
    @State private var showEditMovementPopup = false
    @State private var showDoneToolBar = true
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color(theme.BackgroundColor)
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .center, spacing: 16) {
                    HStack {
                        Spacer()
                        SetTypePicker(setTypeSelection: $setTypeSelection, setTypeColorDark: $setTypeColorDark, setTypeColorLight: $setTypeColorLight)
                        Spacer()
                    }
                    HStack(spacing: 8) {
                        MutateWeightView(weight: $weight, weightStr: $weightStr, isInputActive: _isInputActive, color: Color(setTypeColorLight))
                        if setTypeSelection != "PR" {
                            Spacer()
                            MutateRepsView(reps: $reps, repsStr: $repsStr, isInputActive: _isInputActive, color: Color(setTypeColorLight))
                        }
                    }
                    .toolbar {
                        if showDoneToolBar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    isInputActive = false
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    LogSetButton(setTypeSelection: $setTypeSelection, setTypeColorDark: $setTypeColorDark, setTypeColorLight: $setTypeColorLight)
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
                EditMovementView(movement: movement, movementModel: movementModel, showDoneToolBar: $showDoneToolBar)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditMovementButton(showEditMovementPopup: $showEditMovementPopup, showDoneToolBar: $showDoneToolBar)
                }
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 14) {
                        Image(movement.muscleGroup.lowercased())
                            .font(.caption2)
                            .frame(width: 4, height: 4)
                            .foregroundStyle(.linearGradient(colors: [
                                Color(theme.lightBaseColor),
                                Color(theme.darkBaseColor)
                            ], startPoint: .top, endPoint: .bottom))
                        Text(movement.name)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
