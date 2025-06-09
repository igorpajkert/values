//
//  ValuesPicker.swift
//  Values
//
//  Created by Igor Pajkert on 05/06/2025.
//

import SwiftUI

struct ValuesPicker: View {
    
    @Environment(\.store) private var store
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(store.remainingValues) { value in
                        ValueCard(
                            name: value.name,
                            index: store.getIndex(of: value),
                            isSelected: store.isValueSelected(value),
                            action: { store.selectValue(value) }
                        )
                    }
                }
                .padding()
                .navigationTitle("title.picker")
            }
        }
        switch store.selectionPhase {
        case .ongoing:
            ongoingView
        case .finished:
            finishedView
        case .ended:
            endedView
        }
    }
    
    private var ongoingView: some View {
        Text("text.info.ongoingPhase")
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private var finishedView: some View {
        VStack {
            Text("text.info.finishedPhase")
            Button("button.next", action: store.nextPhase)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .padding()
        }
        .padding()
        .multilineTextAlignment(.center)
    }
    
    private var endedView: some View {
        VStack {
            Text("text.info.endedPhase")
            Button("button.close") { dismiss() }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .padding()
        }
        .padding()
        .multilineTextAlignment(.center)
    }
}

#Preview {
    ValuesPicker()
}
