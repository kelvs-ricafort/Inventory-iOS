//
//  MainView.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/29/26.
//

import SwiftUI

struct MainView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    let container: AppContainer
    
    @State private var selectedItem: Item?
    @State private var showingAddItem = false
    @State private var editingItem: Item?
    
    var body: some View {
        if sizeClass == .compact {
            iPhoneLayout
        } else {
            // iPadLayout
        }
    }
    
    private var iPhoneLayout: some View {
        NavigationStack {
            HomeScreen(
                repository: container.itemsRepository,
                onAddItem: {
                    showingAddItem = true
                },
                onSelectItem: { item in
                    selectedItem = item
                }
            )
            .navigationDestination(item: $selectedItem) { item in
                ItemDetailsScreen(
                    item: item,
                    repository: container.itemsRepository,
                    onEdit: { item in
                        editingItem = item
                    }
                )
            }
            .sheet(isPresented: $showingAddItem) {
                NavigationStack {
                    ItemEntryScreen(repository: container.itemsRepository)
                }
            }
            .sheet(item: $editingItem) { item in
                NavigationStack {
                    ItemEditScreen(item: item, repository: container.itemsRepository)
                }
            }
        }
    }
    
    private var iPadLayout: some View {
        NavigationSplitView {
            NavigationStack {
                HomeScreen(
                    repository: container.itemsRepository,
                    onAddItem: {
                        showingAddItem = true
                    },
                    onSelectItem: { item in
                        selectedItem = item
                    }
                )
            }
        } detail: {
            if let selectedItem {
                ItemDetailsScreen(
                    item: selectedItem,
                    repository: container.itemsRepository,
                    onEdit: { item in
                        editingItem = item
                    }
                )
            } else {
                ContentUnavailableView(
                    "Select an item",
                    systemImage: "shippingbox"
                )
            }
        }
        .sheet(isPresented: $showingAddItem) {
            NavigationStack {
                ItemEntryScreen(repository: container.itemsRepository)
            }
        }
        .sheet(item: $editingItem) { item in
            NavigationStack {
                ItemEditScreen(item: item, repository: container.itemsRepository)
            }
        }
    }
}

#Preview("Main Screen - iPhone") {
    MainView(
        container: AppDataContainer()
    )
}

#Preview("Main Screen - iPad") {
    MainView(
        container: AppDataContainer()
    )
}
