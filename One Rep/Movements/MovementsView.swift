//
//  MovementsView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI
import RealmSwift

struct MovementsView: View {
    
    @State var showAddMovementPopup = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    AddMovementCardButton(showAddMovementPopup: $showAddMovementPopup)
                }
                /// Add new Movement view
                .sheet(isPresented: $showAddMovementPopup) {
                    AddMovementView()
                        .dynamicTypeSize(.xSmall)
                }
            }
        }
    }
}
