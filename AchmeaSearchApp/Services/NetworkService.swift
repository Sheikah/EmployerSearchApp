//
//  NetworkService.swift
//  AchmeaSearchApp
//
//  Created by Annette Straver on 25/03/2025.
//

import Foundation
import SwiftData

class NetworkService {
    let baseURL = "https://cba.kooijmans.nl/CBAEmployerservice.svc/rest/employers"

    func searchEmployers(filter: String, maxRows: Int = 100, modelContext: ModelContext) async throws {
        guard let url = URL(string: "\(baseURL)?filter=\(filter.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&maxRows=\(maxRows)") else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let employers = try JSONDecoder().decode([EmployerModel].self, from: data)

        // Store data in SwiftData
        await saveToDatabase(employers, modelContext: modelContext)
    }

    private func saveToDatabase(_ employers: [EmployerModel], modelContext: ModelContext) async {
        for employer in employers {
            modelContext.insert(employer)
        }
        try? modelContext.save()
    }
}
