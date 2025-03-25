//
//  Employer.swift
//  AchmeaSearchApp
//
//  Created by Annette Straver on 25/03/2025.
//

import Foundation
import SwiftData

@Model
class EmployerModel: Codable {
    
    enum CodingKeys: CodingKey {
        case discountPercentage
        case employerID
        case name
        case place
        case createdAt
    }
    
    var discountPercentage: Int
    @Attribute(.unique) var employerID: Int
    var name: String
    var place: String
    var createdAt: Date
    
    init(discountPercentage: Int, employerID: Int, name: String, place: String, createdAt: Date = Date()) {
        self.discountPercentage = discountPercentage
        self.employerID = employerID
        self.name = name
        self.place = place
        self.createdAt = createdAt
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        discountPercentage = try container.decode(Int.self, forKey: .discountPercentage)
        employerID = try container.decode(Int.self, forKey: .employerID)
        name = try container.decode(String.self, forKey: .name)
        place = try container.decode(String.self, forKey: .place)
        createdAt = try container.decode(Date.self , forKey: .createdAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(discountPercentage, forKey: .discountPercentage)
        try container.encode(employerID, forKey: .employerID)
        try container.encode(name, forKey: .name)
        try container.encode(place, forKey: .place)
        try container.encode(createdAt, forKey: .createdAt)
    }
}
