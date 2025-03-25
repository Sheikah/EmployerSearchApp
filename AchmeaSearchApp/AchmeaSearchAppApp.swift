//
//  AchmeaSearchAppApp.swift
//  AchmeaSearchApp
//
//  Created by Annette Straver on 25/03/2025.
//

import SwiftUI
import SwiftData

@main
struct AchmeaSearchAppApp: App {
    var body: some Scene {
        WindowGroup {
            EmployerSearchView(viewModel: EmployerSearchViewModel())
        }
        .modelContainer(for: [EmployerModel.self])
    }
}
