//
//  ViewRouter.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import Foundation
import SwiftUI
import RealmSwift

/// Class to handle whether to show login or app page
@MainActor class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .syncRealm
    @Published var realm: Realm? = nil
}

enum Page {
    case loginView
    case syncRealm
    case tabView
}
