//
//  ValuesApp.swift
//  Values
//
//  Created by Igor Pajkert on 30/05/2025.
//

import SwiftUI

@main
struct ValuesApp: App {
    
    @State private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            MainView {
                Task {
                    do {
                        try await store.saveEntries()
                    } catch {
                        print("Error saving entries: \(error)")
                    }
                }
            }
            .store(store)
            .task {
                do {
                    try await store.loadEntries()
                } catch {
                    print("Error loading entries: \(error)")
                }
            }
        }
    }
}
