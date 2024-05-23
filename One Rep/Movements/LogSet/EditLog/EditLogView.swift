//
//  EditLogView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/22/24.
//

import SwiftUI
import RealmSwift

struct EditLogView: View {
    
    // MARK: - Variables
    
    @Environment(\.realm) var realm
    @EnvironmentObject var theme: ThemeModel
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var logController: LogController
    
    @ObservedRealmObject var log: Log
    @ObservedRealmObject var movement: Movement
    
    @State private var date = Date()
    
    @FocusState var isInputActive: Bool
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    
                    Text("Edit Log")
                        .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                        .padding(.top, 32)
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            VStack(alignment: .center, spacing: 4) {
                                Text("Edit weight")
                                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                                    .foregroundColor(.secondary)
                                EditWeightTextField(log: log, movement: movement, isInputActive: _isInputActive)
                            }
                            VStack(alignment: .center, spacing: 4) {
                                Text("Edit reps")
                                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                                    .foregroundColor(.secondary)
                                EditRepsTextField(log: log, isInputActive: _isInputActive)
                            }
                        }
                        DatePicker("Date/Time", selection: $date)
                            .datePickerStyle(.graphical)
                            .frame(maxHeight: 400)
                            .padding(.horizontal)
                            .accentColor(colorScheme == .dark ? Color(theme.lightBaseColor) : Color(theme.darkBaseColor))
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        DeleteLogButton(deleteLogInRealm: { self.deleteLogInRealm() })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        UpdateLogButton(updateLogInRealm: { self.updateLogInRealm() })
                    }
                }
            }
            .onAppear {
                date = Date(timeIntervalSince1970: log.date)
            }
        }
    }
    
    // MARK: - Functions
    
    func updateLogInRealm() {
        if let thawedLog = log.thaw() {
            do {
                try realm.write {
                    thawedLog.weight = logController.weight
                    thawedLog.reps = logController.reps
                    thawedLog.date = date.timeIntervalSince1970
                }
            } catch  {
                /// Handle error
            }
        }
    }
    
    func deleteLogInRealm() {
        if let thawedLog = log.thaw() {
            do {
                try realm.write {
                    realm.delete(thawedLog)
                }
            } catch  {
                /// Handle error
            }
        }
    }
    
}
