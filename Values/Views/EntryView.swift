//
//  EntryView.swift
//  Values
//
//  Created by Igor Pajkert on 03/06/2025.
//

import SwiftUI

struct EntryView: View {
    
    @State private var isShowingPicker = false
    
    @Environment(\.store) private var store
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        List {
            ForEach(store.selectedEntry?.values ?? []) { value in
                HStack {
                    Text(value.name)
                    Spacer()
                    let index = getIndex(of: value)
                    Text(index, format: .number)
                }
            }
            .onMove(perform: store.moveValues)
            .listRowBackground(Color.lavender)
        }
        .listStyle(.plain)
        .toolbar {
            EditButton()
        }
        .fullScreenCover(isPresented: $isShowingPicker) {
            ValuesPicker()
        }
        .onAppear {
            if let isPicked = store.selectedEntry?.isPicked {
                if !isPicked {
                    isShowingPicker.toggle()
                }
            }
        }
    }
    
    private func getIndex(of value: Value) -> Int {
        store.selectedEntry?.values.firstIndex(of: value) ?? 0
    }
}

#Preview {
    NavigationStack {
        EntryView()
            .environment(\.store, Store())
    }
}
