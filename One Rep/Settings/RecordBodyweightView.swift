//
//  SetBodyweightView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/3/24.
//

import SwiftUI
import RealmSwift

struct RecordBodyweightView: View {
    
    // MARK: - Vars
    
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var userModel: UserModel
    
    @State var bodyweightStr = "Bodyweight"
    @State var bodyweight: Double = 150
    @State var prevBodyweight: Double = 150
    
    @FocusState var isInputActive: Bool
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            VStack {
                BodyweightTextField(focus: true, isInputActive: _isInputActive, bodyweightStr: $bodyweightStr, bodyweight: $bodyweight)
                    .padding(.horizontal, 16)
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .principal) {
                    Text("Bodyweight")
                        .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    SaveWeightButton(bodyweight: $bodyweight, prevBodyweight: $prevBodyweight, addWeightToRealm: addWeightToRealm)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        isInputActive = false
                    } label: {
                        Text("Done")
                            .foregroundStyle(.primary)
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    }
                }
            }
        }
        .onAppear() {
            if let bodyweightEntry = userModel.bodyweightEntries.last {
                bodyweight = bodyweightEntry.bodyweight
                prevBodyweight = bodyweightEntry.bodyweight
                bodyweightStr = formatWeightString(bodyweightEntry.bodyweight)
            }
        }
    }
    
    func formatWeightString(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
    
    private func addWeightToRealm() {
        let newWeight = BodyweightEntry(bodyweight: bodyweight, timeAdded: Date().timeIntervalSince1970)
        userModel.bodyweightEntries.append(newWeight)
    }
}
