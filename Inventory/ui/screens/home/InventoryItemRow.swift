//
//  InventoryItemRow.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 9/30/26.
//

import SwiftUI

struct InventoryItemRow: View {
    var item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(item.name)
                    .font(.headline)
                
                Spacer()
                Text(item.price, format: .currency(code: "USD"))
                    .font(.subheadline)
            }
            
            Text(item.quantity == 1 ? "1 in stock" : "\(item.quantity) in stock")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        InventoryItemRow(item: PreviewData.item)
    }
}
