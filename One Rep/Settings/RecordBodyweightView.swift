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
    
    @Environment(\.realm) var realm
    
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var userModel: UserModel
    
    @State var bodyweight: Double = 130
    @State var prevBodyweight: Double = 0
    
    @State var fromSettingsView: Bool
    
    @FocusState var isInputActive: Bool
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Enter bodyweight")
                        .padding(.horizontal, 8)
                        .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                        .foregroundColor(.secondary)
                    BodyweightTextField(focus: true, isInputActive: _isInputActive, bodyweight: $bodyweight)
                }
                .padding(.top, fromSettingsView ? 0 : 52)
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    SetWeightButton(bodyweight: $bodyweight, prevBodyweight: $prevBodyweight, addWeightToRealm: addWeightToRealm)
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
            .padding(.horizontal, 16)
        }
        .onAppear() {
            if let bodyweightEntry = userModel.bodyweightEntries.last {
                bodyweight = bodyweightEntry.bodyweight
                prevBodyweight = bodyweightEntry.bodyweight
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
    
    func addWeightToRealm() {
        let newWeight = BodyweightEntry(bodyweight: bodyweight, timeAdded: Date().timeIntervalSince1970)
        prevBodyweight = bodyweight
        $userModel.bodyweightEntries.append(newWeight)
    }
}
