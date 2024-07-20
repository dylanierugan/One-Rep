//
//  SetBodyweightView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/3/24.
//

import SwiftUI

struct RecordBodyweightView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    @EnvironmentObject var errorHandler: ErrorHandler
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Public Properties
    
    @State var fromSettingsView: Bool
    @FocusState var isInputActive: Bool
    
    // MARK: - Private Properties
    
    @State private var bodyweight: Double = 130
    @State private var prevBodyweight: Double = 0
    @State private var showProgressView = false
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            Color(theme.backgroundColor)
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(BodyweightStrings.EnterBodyweight.rawValue)
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
                    if showProgressView {
                        ProgressView()
                    } else {
                        AddNewBodyweightButton(bodyweight: $bodyweight, prevBodyweight: $prevBodyweight) {
                            addBodyweight()
                        }
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        isInputActive = false
                    } label: {
                        Text(BodyweightStrings.Done.rawValue)
                            .foregroundStyle(.primary)
                            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear() {
            if let bodyweightEntry = userViewModel.bodyweightEntries.first {
                bodyweight = bodyweightEntry.bodyweight
                prevBodyweight = bodyweightEntry.bodyweight
            }
        }
    }
    
    // MARK: - Functions
    
    private func formatWeightString(_ weight: Double) -> String {
        if weight.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", weight)
        } else {
            return String(format: "%.1f", weight)
        }
    }
    
    private func addBodyweight() {
        let docId = UUID().uuidString
        let newBodyweight = BodyweightEntry(id: docId, userId: userViewModel.userId, bodyweight: bodyweight, timeAdded: Date().timeIntervalSince1970)
        prevBodyweight = bodyweight
        Task {
            showProgressView = true
            let result = await userViewModel.addBodyweight(bodyweight: newBodyweight)
            errorHandler.handleAddBodyweight(result: result, dismiss: dismiss)
        }
    }
}
