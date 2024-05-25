//
//  LogIndexLabel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/19/24.
//

import SwiftUI

struct LogIndexLabel: View {
    
    @EnvironmentObject var theme: ThemeModel
    
    var index: Int
    
    // MARK: - View
    
    var body: some View {
        Text(String(index))
            .foregroundStyle(.primary)
            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
    }
}
