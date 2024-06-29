//
//  MotherView.swift
//  One Rep
//
//  Created by Dylan Ierugan on 3/16/24.
//

import SwiftUI

/// View holds either login/signup or tabview
struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    // MARK: - View
    
    var body: some View {
        switch viewRouter.currentPage {
        case .loginView:
            LoginView()
        case .loadDataView:
            LoadDataView()
        case .tabView:
            TabHolderView()
        }
    }
}
