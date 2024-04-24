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
        self.BackgroundColor = Colors.BackgroundColor.description
        self.BackgroundElementColor = Colors.BackgroundElementColor.description
        
        self.lightBlue = Colors.LightBlue.description
        self.darkBlue = Colors.DarkBlue.description
        self.darkOrange = Colors.DarkOrange.description
        self.lightOrange = Colors.LightOrange.description
        self.darkPink = Colors.DarkPink.description
        self.lightPink = Colors.LightPink.description
        self.darkYellow = Colors.DarkYellow.description
        self.lightYellow = Colors.LightYellow.description
        
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
    
    @Published var BackgroundColor: String
    @Published var BackgroundElementColor: String
    
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
