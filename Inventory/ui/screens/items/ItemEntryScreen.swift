//
//  ItemEntryScreen.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import SwiftUI
import SwiftData

struct ItemEntryScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: ItemEntryViewModel
    
    init(repository: ItemsRepository) {
        _viewModel = State(initialValue: ItemEntryViewModel(repository: repository))
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $viewModel.name)
                TextField("Price", text: $viewModel.price)
                    .keyboardType(.decimalPad)
                TextField("Quantity", text: $viewModel.quantity)
                    .keyboardType(.numberPad)
            }
            
            Section {
                Button("Save") {
                    Task {
                        await viewModel.save()
                        dismiss()
                    }
                }
                .frame(maxWidth: .infinity)
                .disabled(!viewModel.isValid)
            }
        }
        .navigationTitle("Add Item")
    }
}

#Preview("Add Item") {
    let container = AppDataContainer(inMemory: true)
    
    return NavigationStack {
        ItemEntryScreen(
            repository: container.itemsRepository
        )
    }
}
