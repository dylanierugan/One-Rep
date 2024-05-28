//
//  OneRepProgressView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/27/24.
//

import SwiftUI

struct OneRepProgressView: View {
    
    var text: String
    
    // MARK: - View
    
    var body: some View {
        ProgressView(text)
            .foregroundStyle(.primary)
            .customFont(size: .body, weight: .bold, kerning: 0, design: .rounded)
    }
}
