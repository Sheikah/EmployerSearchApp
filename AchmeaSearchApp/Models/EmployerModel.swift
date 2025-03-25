//
//  Employer.swift
//  AchmeaSearchApp
//
//  Created by Annette Straver on 25/03/2025.
//

import Foundation
import SwiftData

@Model
class EmployerModel: Decodable {
    
    enum CodingKeys: CodingKey {
        case DiscountPercentage
        case EmployerID
        case Name
        case Place
    }
    
    var discountPercentage: Int
    @Attribute(.unique) var employerID: Int
    var name: String
    var place: String
    var createdAt: Date
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        discountPercentage = try container.decode(Int.self, forKey: .DiscountPercentage)
        employerID = try container.decode(Int.self, forKey: .EmployerID)
        name = try container.decode(String.self, forKey: .Name)
        place = try container.decode(String.self, forKey: .Place)
        createdAt = Date()
    }
}
