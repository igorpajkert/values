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
    
    private let values: [Value] = load("data.json")
    
    var body: some View {
        List {
            ForEach(store.selectedEntry?.values ?? values) { value in
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
        .listRowSpacing(10)
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
        .overlay(alignment: .bottom) {
            buttonPicker
        }
    }
    
    private var buttonPicker: some View {
        Button(action: { isShowingPicker.toggle() }) {
            Label("button.picker", systemImage: "chevron.up")
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .font(.title3)
        .shadow(radius: 6)
        .padding()
    }
    
    private func getIndex(of value: Value) -> Int {
        store.selectedEntry?.values.firstIndex(of: value) ?? 0
    }
}

#Preview {
    NavigationStack {
        EntryView()
            .environment(\.store, Store(entries: [Entry(values: load("data.json"))]))
    }
}
