//
//  SetView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/9/24.
//

import SwiftUI

struct LogSetView: View {
    
    @EnvironmentObject var theme: ThemeModel
    
    @State var reps: Int = 12
    @State var repsStr = "12"
    
    @State var weight: Double = 135
    @State var weightStr = "135.0"
    
    @State var setTypeSelection = "Working Set"
    @State var setTypeColor = Color("BlueLight")
    
    @State var bodyWeight = 185
    @State var isBodyWeightSelected = false
    
    var body: some View {
            ZStack {
                Color(theme.BackgroundColor)
                    .ignoresSafeArea()
                VStack {
                    VStack(alignment: .center, spacing: 24) {
                        Text("Bench Press")
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                            .foregroundColor(.primary)
                        HStack {
                            SetTypePicker(setTypeSelection: $setTypeSelection, setTypeColor: $setTypeColor)
                                .padding(.leading, 32)
                            Spacer()
                            VStack(spacing: 16) {
                                MutateWeightView(color: Color(theme.BaseColor), weight: $weight, weightStr: $weightStr)
                                if isBodyWeightSelected {
                                    Text("+ \(bodyWeight) lbs")
                                        .foregroundColor(Color(theme.BaseBlue))
                                        .customFont(size: .caption, weight: .bold, kerning: 0, design: .rounded)
                                }
                                if setTypeSelection != "PR" {
                                    MutateRepsView(color: Color(theme.BaseColor), reps: $reps, repsStr: $repsStr)
                                }
                            }
                            Spacer()
                            BodyWeightButton(isBodyWeightSelected: $isBodyWeightSelected)
                                .padding(.trailing, 32)
                        }
                        LogSetButton(setTypeSelection: $setTypeSelection, setTypeColor: $setTypeColor)
                    }
                    .padding(.vertical, 16)
                    .background(Color(theme.BackgroundElementColor))
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditMovementButton()
                }
            }
    }
}
