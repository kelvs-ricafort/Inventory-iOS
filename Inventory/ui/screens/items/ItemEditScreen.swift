//
//  ItemEditScreen.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import SwiftUI

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
                TextField(
                    "Name",
                    text: $viewModel.name
                )

                TextField(
                    "Price",
                    text: $viewModel.price
                )
                .keyboardType(.decimalPad)

                TextField(
                    "Quantity",
                    text: $viewModel.quantity
                )
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
        .navigationTitle("Edit Item")
    }
}

#Preview {
    NavigationStack {
        ItemEditScreen(
            item: PreviewData.item,
            repository: OfflineItemsRepository(items: PreviewData.items)
        )
    }
}
