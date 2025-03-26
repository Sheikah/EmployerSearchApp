//
//  EncryptionHelper.swift
//  EmployerSearchApp
//
//  Created by Annette Straver on 26/03/2025.
//

import Foundation
import CryptoKit

struct EncryptionHelper {
    
    // Generate a symmetric key
    static func generateSymmetricKey() -> SymmetricKey {
        return SymmetricKey(size: .bits256)
    }
    
    static func encryptData(_ data: Data, using key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }
    
    static func decryptData(_ encryptedData: Data, using key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
        return try AES.GCM.open(sealedBox, using: key)
    }
}
