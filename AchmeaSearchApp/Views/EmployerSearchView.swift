//
//  EmployerSearchView.swift
//  AchmeaSearchApp
//
//  Created by Annette Straver on 25/03/2025.
//

import SwiftUI
import SwiftData

struct EmployerSearchView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var employers: [EmployerModel]
    
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    
    func addItem() {
        withAnimation {
            let newItem = EmployerModel(discountPercentage: 10, employerID: 0, name: "HelloWorld", place: "Gouda")
            modelContext.insert(newItem)
        }
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
    EmployerSearchView()
        .modelContainer(for: EmployerModel.self, inMemory: true)
}
