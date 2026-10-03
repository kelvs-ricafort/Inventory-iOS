//
//  AboutScreen.swift
//  Inventory
//
//  Created by Kelvin Ricafort on 10/3/26.
//

import SwiftUI

struct AboutScreen: View {
    var body: some View {
        NavigationStack {
             Form {
                Section {
                    VStack(spacing: 12) {
                        Image("AppIconImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("Inventory")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("An inventory tracking application for managing items.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                }
                 Section("App Info") {
                     HStack {
                         Text("Version:")
                             .fontWeight(.bold)
                         Spacer()
                         Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown")
                             .foregroundStyle(.secondary)
                     }
                     HStack {
                         Text("Build:")
                             .fontWeight(.bold)
                         Spacer()
                         Text(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown")
                             .foregroundStyle(.secondary)
                     }
                 }
                 
                 Section("Developer") {
                     HStack {
                         Text("Developer Name:")
                             .fontWeight(.bold)
                         Spacer()
                         Text("Kelvin Ricafort")
                             .foregroundStyle(.secondary)
                     }
                 }
                 
                 Section("Features") {
                     Label("Inventory Management", systemImage: "shippingbox")
                     Label("Add Items", systemImage: "plus.circle")
                     Label("Edit Items", systemImage: "pencil")
                     Label("Sell Items", systemImage: "cart")
                     Label("Delete Items", systemImage: "trash")
                     Label("Multiple Language Support", systemImage: "globe")
                     Label("Offline Local Data Storage", systemImage: "icloud.slash")
                     Label("Online Data Sync", systemImage: "icloud")
                     Label("Dark Mode Support", systemImage: "moon")
                 }
                 .navigationTitle("About")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AboutScreen()
    }
}
