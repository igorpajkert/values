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
            if store.entries.isEmpty {
                placeholderView
            } else {
                ScrollView {
                    ForEach(store.entries) { entry in
                        EntryCard(
                            dateCreated: entry.dateCreated,
                            dateModified: entry.dateModified,
                            primaryAction: { store.selectEntry(entry) },
                            deleteAction: { store.markToDelete(entry) }
                        )
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
        .alert(
            "alert.deleteConfirmation.title",
            isPresented: $store.isShowingDeleteAlert,
            actions: {
                Button("button.delete", role: .destructive) {
                    store.deleteEntry()
                }
            }, message: {
                Text("text.deleteConfirmation.message")
            })
    }
    
    private var toolbarButtonAdd: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: store.addEntry) {
                Image(systemName: "plus")
            }
        }
    }
    
    private var placeholderView: some View {
        VStack {
            Button(action: store.addEntry) {
                Image(systemName: "plus")
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.circle)
            .font(.title)
            .padding()
            Text("text.addEntry")
        }
    }
}

#Preview {
    NavigationStack {
        EntriesView()
            .environment(\.store, Store(entries: []))
    }
}
