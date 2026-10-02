//
//  MainView.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/29/26.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    let container: AppContainer
    
    @State private var selectedItem: Item?
    @State private var showingAddItem = false
    @State private var editingItem: Item?
    
    @State private var showSettings = false
    @State private var showAbout = false
    
    var body: some View {
        if sizeClass == .compact {
            iPhoneLayout
        } else {
            iPadLayout
        }
    }
    
    // MARK: - iPhone
    private var iPhoneLayout: some View {
        NavigationStack {
            HomeScreen(
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    menu
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
            .sheet(isPresented: $showSettings) {
                NavigationStack {
                    SettingsScreen()
                }
            }
            .sheet(isPresented: $showAbout) {
                NavigationStack {
                    // Show About Screen
                }
            }
        }
    }
    
    // MARK: - iPad
    private var iPadLayout: some View {
        NavigationSplitView {
            NavigationStack {
                HomeScreen(
                    onAddItem: {
                        showingAddItem = true
                    },
                    onSelectItem: { item in
                        selectedItem = item
                    }
                )
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        menu
                    }
                }
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
        .sheet(isPresented: $showSettings) {
            NavigationStack {
                SettingsScreen()
            }
        }
        .sheet(isPresented: $showAbout) {
            NavigationStack {
                // Show AboutScreen
            }
        }
    }
    
    // MARK: - Menu
    private var menu: some View {
        Menu {
            Button {
                showSettings = true
            } label: {
                Label("Settings", systemImage: "gear")
            }
            
            Button {
                showAbout = true
            } label: {
                Label("About", systemImage: "info.circle")
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
        .accessibilityLabel("More")
    }
}

#Preview("Main Screen - iPhone") {
    let container = AppDataContainer(inMemory: true)
    let context = container.modelContainer.mainContext
    
    PreviewData.items.forEach { item in
        context.insert(item)
    }
    
    return MainView(
        container: AppDataContainer()
    )
}

#Preview("Main Screen - iPad") {
    let container = AppDataContainer(inMemory: true)
    let context = container.modelContainer.mainContext
    
    PreviewData.items.forEach { item in
        context.insert(item)
    }
    
    return MainView(
        container: AppDataContainer()
    )
}
