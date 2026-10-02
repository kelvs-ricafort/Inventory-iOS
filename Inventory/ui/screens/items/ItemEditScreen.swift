//
//  ItemEditScreen.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import SwiftUI
import SwiftData

struct ItemEditScreen: View {

    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: ItemEditViewModel
    
    init(
        item: Item,
        repository: ItemsRepository
    ) {
        _viewModel = State(
            initialValue: ItemEditViewModel(
                item: item,
                repository: repository
            )
        )
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
                Button {
                    Task {
                        await viewModel.save()
                        dismiss()
                    }
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .disabled(!viewModel.isValid)
            }
        }
        .navigationTitle("Edit Item")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let container = AppDataContainer(inMemory: true)
    let context = container.modelContainer.mainContext
    
    let item = PreviewData.item
    
    context.insert(item)
    
    return NavigationStack {
        ItemEditScreen(item: item, repository: container.itemsRepository)
    }
}
