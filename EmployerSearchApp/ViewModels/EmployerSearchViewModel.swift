//
//  EmployerSearchViewModel.swift
//  EmployerSearchApp
//
//  Created by Annette Straver on 25/03/2025.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class EmployerSearchViewModel {
    var employers: [EmployerModel] = []
    var isLoading = false
    var errorMessage: String?
    
    func search(filter: String, modelContext: ModelContext) {
        // Endpoint only returns values if filter contains more than 1 character.
        if filter.count < 2 {
            loadCachedEmployers(modelContext: modelContext)
        } else {
            searchEmployers(filter: filter, modelContext: modelContext)
        }
    }
    
    func showCachedEmployers(modelContext: ModelContext) {
        loadCachedEmployers(modelContext: modelContext)
    }
    
    private func searchEmployers(filter: String, modelContext: ModelContext) {
        Task {
            do {
                let service = NetworkService()
                try await service.searchEmployers(filter: filter, modelContext: modelContext)
                loadCachedEmployers(modelContext: modelContext)
            } catch {
                //TODO: Show a nice error to the user.
            }
        }
    }

    private func loadCachedEmployers(modelContext: ModelContext) {
        // FIXME: I am curious why this piece of code breaks the app without showing any error message. When I enter a string in the predicate there is no issue but it seems to not support a Date..
//        let fetchDescriptor = FetchDescriptor<EmployerModel>(predicate: #Predicate { employer in
//            employer.createdAt > Calendar.current.date(byAdding: .day, value: -7, to: Date())!
//        })
//        employers = (try? modelContext.fetch(fetchDescriptor)) ?? []
    }
}
