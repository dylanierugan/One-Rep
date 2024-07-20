//
//  LogViewSubHeading.swift
//  One Rep
//
//  Created by Dylan Ierugan on 7/7/24.
//

import Foundation
import SwiftUI

struct LogViewSubHeading: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var logController: LogController
    @EnvironmentObject var logViewModel: LogViewModel
    
    // MARK: - Public Properties
    
    var movement: Movement
    
    // MARK: - View
    
    var body: some View {
        VStack {
            if logViewModel.filteredLogs.count != 0 {
                if movement.movementType != .Bodyweight {
                    WeightHorizontalScroller(movement: movement)
                }
            } else {
                HStack {
                    Spacer()
                    Text(InfoText.NoData.rawValue)
                        .customFont(size: .body, weight: .semibold, kerning: 0, design: .rounded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .padding(.top, 36)
                    Spacer()
                }
            }
        }
    }
}
