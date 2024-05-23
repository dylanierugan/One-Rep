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
    
    @EnvironmentObject var theme: ThemeModel
    
    @ObservedRealmObject var log: Log
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                
                VStack(spacing: 36) {
                    Text("Edit Log")
                        .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                }
                
            }
        }
    }
}
