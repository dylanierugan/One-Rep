//
//  ThemeColorModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/6/24.
//

import Foundation
import SwiftUI

class ThemeModel: ObservableObject {
    
    init(accent: String, colorScheme: ColorScheme) {
        self.accent = accent
        self.backgroundColor = Colors.BackgroundColor.rawValue
        self.backgroundElementColor = Colors.BackgroundElementColor.rawValue
        
        self.darkRed = Colors.DarkRed.rawValue
        self.lightRed = Colors.LightRed.rawValue
        
        self.lightBlue = Colors.LightBlue.rawValue
        self.darkBlue = Colors.DarkBlue.rawValue
        self.darkOrange = Colors.DarkOrange.rawValue
        self.lightOrange = Colors.LightOrange.rawValue
        self.darkPink = Colors.DarkPink.rawValue
        self.lightPink = Colors.LightPink.rawValue
        self.darkYellow = Colors.DarkYellow.rawValue
        self.lightYellow = Colors.LightYellow.rawValue
        
        if accent == Colors.LightGreen.rawValue {
            self.darkBaseColor = Colors.DarkGreen.rawValue
            self.lightBaseColor = Colors.LightGreen.rawValue
        } else if accent == Colors.LightPink.rawValue {
            self.darkBaseColor = Colors.DarkPink.rawValue
            self.lightBaseColor = Colors.LightPink.rawValue
        } else if accent == Colors.Primary.rawValue {
            self.lightBaseColor = Colors.Primary.rawValue
            self.darkBaseColor = Colors.Primary.rawValue
        } else {
            self.darkBaseColor = Colors.DarkGreen.rawValue
            self.lightBaseColor = Colors.LightGreen.rawValue
        }
        
        self.colorScheme = colorScheme
    }
    
    @Published var accent: String
    
    @Published var lightBaseColor: String
    @Published var darkBaseColor: String
    
    @Published var lightBlue: String
    @Published var darkBlue: String
    @Published var darkOrange: String
    @Published var lightOrange: String
    @Published var darkPink: String
    @Published var lightPink: String
    @Published var darkYellow: String
    @Published var lightYellow: String
    
    @Published var backgroundColor: String
    @Published var backgroundElementColor: String
    
    @Published var darkRed: String
    @Published var lightRed: String
    
    @Published var colorScheme: ColorScheme
    
    func changeColor(color: String) {
        if color == Colors.LightGreen.rawValue {
            self.lightBaseColor = Colors.LightGreen.rawValue
            self.darkBaseColor = Colors.DarkGreen.rawValue
        } else if accent == Colors.LightPink.rawValue {
            self.lightBaseColor = Colors.LightPink.rawValue
            self.darkBaseColor = Colors.DarkPink.rawValue
        } else if accent == Colors.Primary.rawValue {
            self.lightBaseColor = Colors.Primary.rawValue
            self.darkBaseColor = Colors.Primary.rawValue
        }
    }
}
