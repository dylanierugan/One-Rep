//
//  ViewRouter.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import Foundation
import SwiftUI

/// Class to handle whether to show login or app page
class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .login
}

enum Page {
    case main
    case login
}
