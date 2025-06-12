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
        VStack {
            progressBar
            Text("text.info.ongoingPhase")
                .multilineTextAlignment(.center)
                .padding()
        }
        .background(.ultraThinMaterial, ignoresSafeAreaEdges: .all)
    }
    
    private var finishedView: some View {
        VStack {
            progressBar
            Text("text.info.finishedPhase")
                .padding()
            Button("button.next", action: store.nextPhase)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
        }
        .multilineTextAlignment(.center)
        .background(.ultraThinMaterial, ignoresSafeAreaEdges: .all)
    }
    
    private var endedView: some View {
        VStack {
            progressBar
            Text("text.info.endedPhase")
                .padding()
            Button("button.close") { dismiss() }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
        }
        .multilineTextAlignment(.center)
        .background(.ultraThinMaterial, ignoresSafeAreaEdges: .all)
    }
    
    private var progressBar: some View {
        ProgressView(
            value: Float(store.selectedValues.count),
            total: Float(store.values.count)
        )
    }
}

#Preview {
    ValuesPicker()
}
