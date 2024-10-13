//
//  CheckMarkSubscriptionView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/12/24.
//

import SwiftUI

struct CheckMarkSubscriptionView: View {
    
    // MARK: - Public Properties
    
    var color: Color
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Image(systemName: Icons.Checkmark.rawValue)
                .font(.caption2.bold())
                .foregroundColor(.reversePrimary)
                .zIndex(1)
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(color)
        }
    }
}
