//
//  SubscriptionEnums.swift
//  One Rep
//
//  Created by Dylan Ierugan on 10/12/24.
//

import Foundation

enum UserCap {
    case none
    case movement
    case routine
}

enum SubscriptionChoice {
    case yearly
    case monthly
}

enum SubscriptionStrings: String {
    case MovementCap = "You've reached your 7 movement cap."
    case RoutineCap = "You've reached your 2 routine cap."
    case UpgradeTo = "Upgrade to"
    case OneRepUnlimited = "One Rep Unlimited"
    case Free = "FREE"
    case Member = "MEMBER"
    case MovementTracking = "Movement Tracking"
    case RoutineTracking = "Routine Tracking"
    case ActivityHistory = "Activity History"
    case Charts = "Charts"
    case Movements = "Movements"
    case Routines = "Routines"
    case ComingSoong = "ComingSoon"
    case Subscribe = "Subscribe"
    case DiscountPercent = "48% off"
    case TermsAndConditions = "Terms and Conditions"
}

enum SubscriptionTermStrings: String {
    case TermTitle = "One Rep Unlimited\nTerms and Conditions"
    case TermBilling = "• You will be billed by Apple from your Apple account."
    case TermUnlimitedAccess = "• As a One Rep Premium subscriber, you will have unlimited access to all features."
    case TermUnsubscribe = "• Should you unsubscribe, your membership will remain until the end of your term. Once expired, you will only have access to the first 7 movements and 2 routines you made."
    case TermResubscribe = "• Should you resubscribe, you will regain access to the movements and routines you made during your old subscription."
    case TermQuestions = "For any questions, contact support in the settings."
}
