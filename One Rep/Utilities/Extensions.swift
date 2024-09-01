//
//  Extensions.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/1/24.
//

import Foundation
import UIKit

/// Allows for custom font on the navigation title
extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor  .white]
        
        let titleTextStyle = UIFont.TextStyle.body
        let largeTtitleTextStyle = UIFont.TextStyle.largeTitle
        let titleFont = UIFont.preferredFont(forTextStyle: titleTextStyle, compatibleWith: nil)
        let largeTtitle = UIFont.preferredFont(forTextStyle: largeTtitleTextStyle, compatibleWith: nil)
        
        if let descriptor = titleFont.fontDescriptor.withDesign(.rounded)?.withSymbolicTraits(.traitBold) {
            let customFont = UIFont(descriptor: descriptor, size: titleFont.pointSize)
            appearance.titleTextAttributes = [ .font : customFont]
        }
        if let descriptor = titleFont.fontDescriptor.withDesign(.rounded)?.withSymbolicTraits(.traitBold) {
            let customFont = UIFont(descriptor: descriptor, size: largeTtitle.pointSize)
            appearance.largeTitleTextAttributes = [ .font : customFont]
        }
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
}

/// Removes navigation back buttont text
extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
