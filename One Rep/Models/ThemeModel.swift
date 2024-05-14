//
//  ThemeColorModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 4/6/24.
//

import Foundation

class ThemeModel: ObservableObject {
    
    init(accent: String) {
        self.accent = accent
        self.backgroundColor = Colors.BackgroundColor.description
        self.backgroundElementColor = Colors.BackgroundElementColor.description
        
        self.darkRed = Colors.DarkRed.description
        self.lightRed = Colors.LightRed.description
        
        self.lightBlue = Colors.LightBlue.description
        self.darkBlue = Colors.DarkBlue.description
        self.darkOrange = Colors.DarkOrange.description
        self.lightOrange = Colors.LightOrange.description
        self.darkPink = Colors.DarkPink.description
        self.lightPink = Colors.LightPink.description
        self.darkYellow = Colors.DarkYellow.description
        self.lightYellow = Colors.LightYellow.description
        
        self.primary = Colors.Primary.description
        self.reversePrimary = Colors.ReversePrimary.description
        
        if accent == Colors.LightGreen.description {
            self.darkBaseColor = Colors.DarkGreen.description
            self.lightBaseColor = Colors.LightGreen.description
        } else if accent == Colors.LightPink.description {
            self.darkBaseColor = Colors.DarkPink.description
            self.lightBaseColor = Colors.LightPink.description
        } else {
            self.darkBaseColor = Colors.DarkGreen.description
            self.lightBaseColor = Colors.LightGreen.description
        }
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
    
    @Published var primary: String
    @Published var reversePrimary: String
    
    @Published var darkRed: String
    @Published var lightRed: String
    
    func changeColor(color: String) {
        if color == Colors.LightGreen.description {
            self.lightBaseColor = Colors.LightGreen.description
            self.darkBaseColor = Colors.DarkGreen.description
        } else if accent == Colors.LightPink.description {
            self.lightBaseColor = Colors.LightPink.description
            self.darkBaseColor = Colors.DarkPink.description
        }
    }
}
