//
//  ItemDetailsScreen.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import SwiftUI
import SwiftData

struct ItemDetailsScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: ItemDetailsViewModel
    @State private var showingDeleteConfirmation = false
    
    let onEdit: (Item) -> Void
    
    init(
        item: Item,
        repository: ItemsRepository,
        onEdit: @escaping (Item) -> Void
    ) {
        _viewModel = State(
            initialValue: ItemDetailsViewModel(
                item: item,
                repository: repository
            )
        )
        
        self.onEdit = onEdit
    }
    
    var body: some View {
        Form {
            Section {
                detailRow(
                    title: "Item",
                    value: viewModel.item.name
                )
                
                detailRow(
                    title: "Quantity",
                    value: "\(viewModel.item.quantity)"
                )
                
                detailRow(
                    title: "Price",
                    value: viewModel.item.price,
                    format: .currency(code: "USD")
                )
            }
            
            Section {
                Button("Sell") {
                    Task {
                        await viewModel.sellItem()
                    }
                }
                .disabled(viewModel.item.isOutOfStock)
                
                Button("Delete", role: .destructive) {
                    showingDeleteConfirmation = true
                }
            }
        }
        .navigationTitle("Item Details")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    onEdit(viewModel.item)
                }
            }
        }
        .confirmationDialog(
            "Delete Item?",
            isPresented: $showingDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                Task {
                    await viewModel.deleteItem()
                    dismiss()
                }
            }
            
            Button("Cancel", role: .cancel) {}
        }
    }
    
    private func detailRow(
        title: String,
        value: String
    ) -> some View {
        LabeledContent(title) {
            Text(value)
                .fontWeight(.bold)
        }
    }
    
    private func detailRow(
        title: String,
        value: Double,
        format: FloatingPointFormatStyle<Double>.Currency
    ) -> some View {
        LabeledContent(title) {
            Text(value, format: format)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    let container = AppDataContainer(inMemory: true)
    let context = container.modelContainer.mainContext
   
    let item = PreviewData.item
    
    context.insert(item)
    
    return NavigationStack {
        ItemDetailsScreen(
            item: item,
            repository: container.itemsRepository,
            onEdit: { _ in }
        )
    }
}
