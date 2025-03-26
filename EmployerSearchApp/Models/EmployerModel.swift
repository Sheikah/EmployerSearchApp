//
//  Employer.swift
//  EmployerSearchApp
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
    var encryptedName: Data
    var place: String
    var createdAt: Date
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        discountPercentage = try container.decode(Int.self, forKey: .DiscountPercentage)
        employerID = try container.decode(Int.self, forKey: .EmployerID)
        let name = try container.decode(String.self, forKey: .Name)
        encryptedName = try! EncryptionHelper.encryptData(name.data(using: .utf8)!, using: KeychainHelper.getSymmetricKey()!)
        place = try container.decode(String.self, forKey: .Place)
        createdAt = Date()
    }
    
    func name() -> String {
        // sorry for the !, no time to handle errors nicely.
        let decryptedData = try! EncryptionHelper.decryptData(encryptedName, using: KeychainHelper.getSymmetricKey()!)
        return String(data: decryptedData, encoding: .utf8) ?? ""
    }
}
