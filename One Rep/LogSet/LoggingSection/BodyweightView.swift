//
//  BodyweightView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 6/15/24.
//

import SwiftUI
import RealmSwift

struct BodyweightView: View {
    
    // MARK: - Vars
    
    @EnvironmentObject var logViewModel: LogViewModel
    
    @ObservedRealmObject var userModel: UserModel
    
    // MARK: - View
    
    var body: some View {
        NavigationLink {
            RecordBodyweightView(userModel: userModel, fromSettingsView: false)
        } label: {
            VStack(spacing: 12) {
                Text("Bodyweight")
                    .customFont(size: .caption, weight: .regular, kerning: 0, design: .rounded)
                    .foregroundColor(.secondary).opacity(0.7)
                HStack {
                    if let bodyweightEntry = userModel.bodyweightEntries.last {
                        Image(systemName: Icons.FigureArmsOpen.description)
                            .fontWeight(.black)
                        Text("\(bodyweightEntry.bodyweight.clean)  \(logViewModel.unit.rawValue)")
                    }
                }
            }
        }
    }
}
