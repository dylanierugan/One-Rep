//
//  EditMovementView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/3/24.
//

import SwiftUI

struct EditMovementView: View {
    @State private var deleteConfirmedClicked = false
    @State private var showingDeleteMovementAlert = false
    
    var body: some View {
        DeleteMovementButton(deleteConfirmedClicked: $deleteConfirmedClicked, showingDeleteMovementAlert: $showingDeleteMovementAlert)
    }
}

#Preview {
    EditMovementView()
}
