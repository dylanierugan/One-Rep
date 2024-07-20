//
//  DateView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 5/18/24.
//

import SwiftUI

struct DateView: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var dateViewModel: DateViewModel
    
    // MARK: - View
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            Text("\(dateViewModel.formattedSelectedDate())")
                .customFont(size: .title3, weight: .bold, kerning: 0, design: .rounded)
        }
    }
}
