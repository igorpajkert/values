//
//  EntriesView.swift
//  Values
//
//  Created by Igor Pajkert on 02/06/2025.
//

import SwiftUI

struct EntriesView: View {
    
    @Environment(\.store) private var store
    
    var body: some View {
        @Bindable var store = store
        ZStack {
            BorderMeshGradient()
            ScrollView {
                ForEach(store.entries) { entry in
                    EntryCard(
                        dateCreated: entry.dateCreated,
                        dateModified: entry.dateModified) {
                            store.selectEntry(entry)
                        }
                }
            }
        }
        .navigationTitle("title.entries")
        .toolbar {
            toolbarButtonAdd
        }
        .navigationDestination(item: $store.selectedEntry) { entry in
            EntryView()
        }
    }
    
    private var toolbarButtonAdd: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: store.addEntry) {
                Image(systemName: "plus")
            }
        }
    }
}

#Preview {
    NavigationStack {
        EntriesView()
    }
}
