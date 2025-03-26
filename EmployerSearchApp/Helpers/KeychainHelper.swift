//
//  KeychainHelper.swift
//  EmployerSearchApp
//
//  Created by Annette Straver on 26/03/2025.
//

import Foundation
import CryptoKit

// Because I don't have much time, I asked another team member from Achmea to write a KeychainHelper for me.

class KeychainHelper {

    // This key will be used to identify the item in the Keychain
    private static let keychainService = "com.daanvermeulen.EmployerSearchApp"
    private static let keychainAccount = "encryptionKeyAccount"

    // Store the symmetric key in the Keychain
    static func saveSymmetricKey(_ key: SymmetricKey) throws {
        // Convert SymmetricKey to Data
        let keyData = key.withUnsafeBytes { Data(Array($0)) }

        // Create a dictionary of attributes for the key
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: keychainAccount,
            kSecValueData as String: keyData
        ]

        // Delete any existing item
        SecItemDelete(query as CFDictionary)

        // Add the new key to the Keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.unableToSave
        }
    }

    // Retrieve the symmetric key from the Keychain
    static func getSymmetricKey() throws -> SymmetricKey? {
        // Create a query to search for the key
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: keychainAccount,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                return nil // Key not found
            } else {
                throw KeychainError.unableToRetrieve
            }
        }

        // Convert the retrieved data back to a SymmetricKey
        guard let keyData = item as? Data else { throw KeychainError.invalidData }
        return SymmetricKey(data: keyData)
    }

    // Delete the symmetric key from the Keychain (optional if needed)
    static func deleteSymmetricKey() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: keychainAccount
        ]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess else {
            throw KeychainError.unableToDelete
        }
    }
}

// Keychain-related errors
enum KeychainError: Error {
    case unableToSave
    case unableToRetrieve
    case invalidData
    case unableToDelete
}
