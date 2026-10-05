//
//  HomeScreen.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    @Query(
        sort: \Item.id,
        order: .reverse
    )
    private var items: [Item]
    
    let onAddItem: () -> Void
    let onSelectItem: (Item) -> Void
    
    var body: some View {
        Group {
            if items.isEmpty {
                ContentUnavailableView(
                    "No Items",
                    systemImage: "shippingbox",
                    description: Text("No items are currently in the inventory.")
                )
            } else {
                List(items) { item in
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
    }
}

@MainActor
private struct HomeScreenPreview: View {
    private let container: AppDataContainer
    
    init(hasItems: Bool) {
        container = AppDataContainer(inMemory: true)
        
        if hasItems {
            PreviewData.items.forEach(container.modelContainer.mainContext.insert)
        }
    }
    
    var body: some View {
        NavigationStack {
            HomeScreen(
                onAddItem: {},
                onSelectItem: { _ in }
            )
        }
        .modelContainer(container.modelContainer)
    }
}

#Preview("Home - Items") {
    HomeScreenPreview(hasItems: true)
}

#Preview("Home - Empty") {
    HomeScreenPreview(hasItems: false)
}
