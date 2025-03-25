//
//  Employer.swift
//  AchmeaSearchApp
//
//  Created by Annette Straver on 25/03/2025.
//

import SwiftData

@Model
class Employer {
    var discountPercentage: Int
    var employerID: Int
    var name: String
    var place: String
    
    init(discountPercentage: Int, employerID: Int, name: String, place: String) {
        self.discountPercentage = discountPercentage
        self.employerID = employerID
        self.name = name
        self.place = place
   }
}
