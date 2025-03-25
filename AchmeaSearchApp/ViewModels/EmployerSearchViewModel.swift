//
//  EmployerSearchViewModel.swift
//  AchmeaSearchApp
//
//  Created by Annette Straver on 25/03/2025.
//

import SwiftData
import Foundation
import SwiftUICore

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
    
    private func searchEmployers(filter: String, modelContext: ModelContext) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let service = NetworkService()
                try await service.searchEmployers(filter: filter, modelContext: modelContext)
                loadCachedEmployers(modelContext: modelContext)
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }

    private func loadCachedEmployers(modelContext: ModelContext) {
        // TODO
    }
}
