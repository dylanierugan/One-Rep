//
//  HapticManager.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/26/24.
//

import CoreHaptics
import SwiftUI

/// Class to manage vibrations
class HapticManager {
    static let instance = HapticManager() /// Singleton
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
