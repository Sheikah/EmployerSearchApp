//
//  EmployerSearchView.swift
//  EmployerSearchApp
//
//  Created by Annette Straver on 25/03/2025.
//

import SwiftUI
import SwiftData

struct EmployerSearchView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var employers: [EmployerModel]
    let viewModel: EmployerSearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List(employers) { employer in
                    HStack {
                        Text(employer.name)
                        Spacer()
                        Text(employer.discountPercentage, format: .number)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    // Temp code for testing.
    func addItem() {
        viewModel.search(filter: "ach", modelContext: modelContext)
    }

    func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(employers[index])
            }
        }
    }
}

#Preview {
    EmployerSearchView(viewModel: EmployerSearchViewModel())
        .modelContainer(for: EmployerModel.self, inMemory: true)
}
