//
//  UserModel.swift
//  One Rep
//
//  Created by Dylan Ierugan on 9/13/24.
//

import Foundation

public struct UserModel: Codable {
    
    let userId: String
    let isAnonymous: Bool?
    let email: String?
    var isPremium: Bool
    let dateCreated: Date?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.isAnonymous = auth.isAnonymous
        self.email = auth.email
        self.isPremium = false
        self.dateCreated = Date()
    }
    
    init(
        userId: String,
        isAnonymous: Bool? = nil,
        email: String? = nil,
        isPremium: Bool? = nil,
        dateCreated: Date? = nil
    ) {
        self.userId = userId
        self.isAnonymous = isAnonymous
        self.email = email
        self.isPremium = isPremium ?? false
        self.dateCreated = dateCreated
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case isAnonymous = "is_anonymous"
        case email = "email"
        case isPremium = "is_premium"
        case dateCreated = "date_created"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium) ?? false
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
    }
}
