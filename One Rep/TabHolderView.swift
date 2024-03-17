//
//  TabHolderView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI

struct TabHolderView: View {
        
    @State var loadingUser = true
    @State var showUserError = false
    @State var loadingMovementData = true
    @State var loadingRoutineData = true
    @State var showLoadDataError = false
    @State var movementsLoading = true
    @State var showMovementLoadingError = true
    @State var movementLoadingErrorMessage = ""
    @State var errorMessage = ""
    
    var body: some View {
            /// TabView holds 2 tabs: Movements and Settings
            TabView() {
                MovementsView()
                    .tabItem {
                        Image(systemName: Icons.FigureStrengthTraining.description)
                    }
                    .dynamicTypeSize(.xSmall)
                SettingsView()
                    .tabItem {
                        Image(systemName: Icons.PersonFill.description)
                    }
                    .dynamicTypeSize(.xSmall)
            }
            .font(.headline)
            .accentColor(.primary)
    }

}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabHolderView()
    }
}
