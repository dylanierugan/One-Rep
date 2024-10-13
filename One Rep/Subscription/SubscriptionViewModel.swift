//
//  SubscriptionViewModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/12/24.
//

import Foundation

class SubscriptionViewModel: ObservableObject {
    
    init(userCap: UserCap, prompted: Bool, subscriptionChoice: SubscriptionChoice, showTermsPopup: Bool = false) {
        self.userCap = userCap
        self.prompted = prompted
        self.subscriptionChoice = subscriptionChoice
        self.showTermsPopup = showTermsPopup
    }
    
    @Published var userCap: UserCap
    @Published var prompted: Bool
    @Published var subscriptionChoice: SubscriptionChoice = .yearly
    @Published var showTermsPopup = false
    
}
