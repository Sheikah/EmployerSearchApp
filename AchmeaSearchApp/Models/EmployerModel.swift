//
//  Employer.swift
//  AchmeaSearchApp
//
//  Created by Annette Straver on 25/03/2025.
//

import Foundation
import SwiftData

@Model
class EmployerModel {
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
}
