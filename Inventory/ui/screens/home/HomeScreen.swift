//
//  HomeScreen.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import SwiftUI

struct HomeScreen: View {
    @State var viewModel: HomeViewModel
    let onAddItem: () -> Void
    let onSelectItem: (Item) -> Void
    
    init(
        repository: ItemsRepository,
        onAddItem: @escaping () -> Void,
        onSelectItem: @escaping (Item) -> Void
    ) {
        _viewModel = State(initialValue: HomeViewModel(repository: repository))
        self.onAddItem = onAddItem
        self.onSelectItem = onSelectItem
    }
    
    var body: some View {
        Group {
            if viewModel.items.isEmpty {
                ContentUnavailableView(
                    "No Items",
                    systemImage: "shippingbox",
                    description: Text("No items are currently in the inventory.")
                )
            } else {
                List(viewModel.items) { item in
                    Button {
                        onSelectItem(item)
                    } label: {
                        InventoryItemRow(item: item)
                    }
                    .buttonStyle(.plain)
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Inventory")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: onAddItem) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add Item")
            }
        }
        .task {
            await viewModel.loadItems()
        }
    }
}

#Preview("Home - Items") {
    NavigationStack {
        HomeScreen(
            repository: OfflineItemsRepository(items: PreviewData.items),
            onAddItem: {}, onSelectItem: { _ in }
        )
    }
}

#Preview("Home - Empty") {
    NavigationStack {
        HomeScreen(
            repository: OfflineItemsRepository(),
            onAddItem: {},
            onSelectItem: { _ in }
        )
    }
}


