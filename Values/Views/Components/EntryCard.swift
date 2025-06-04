//
//  EntryCard.swift
//  Values
//
//  Created by Igor Pajkert on 03/06/2025.
//

import SwiftUI

struct EntryCard: View {
    
    @State private var isExpanded = false
    @State private var offset: CGFloat = 50
    
    let dateCreated: Date
    let dateModified: Date
    let primaryAction: () -> Void
    let deleteAction: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                textDateCreated
                Divider()
                textDateModified
            }
            Spacer()
            if isExpanded {
                buttonDelete
            }
            buttonAction
        }
        .padding()
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
    
    private var textDateCreated: some View {
        Text(dateCreated, format: .dateTime.day().month().year().hour().minute())
            .font(.title)
            .lineLimit(1)
    }
    
    private var textDateModified: some View {
        Text("text.lastModified: \(dateModified.formatted(.dateTime.day().month().year().hour().minute()))")
            .lineLimit(1)
    }
    
    private var buttonAction: some View {
        Button(action: primaryAction) {
            Image(systemName: "chevron.right")
                .font(.system(size: 25))
                .imageScale(.large)
                .padding(5)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.circle)
    }
    
    private var buttonDelete: some View {
        Button(action: deleteAction) {
            Image(systemName: "trash")
                .font(.system(size: 15))
                .imageScale(.large)
                .padding(5)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.circle)
        .tint(.red)
        .offset(x: offset)
        .onAppear {
            withAnimation(.bouncy) {
                offset = 0
            }
        }
        .onDisappear {
            withAnimation {
                offset = 50
            }
        }
    }
}

#Preview {
    EntryCard(
        dateCreated: .now,
        dateModified: .now,
        primaryAction: {},
        deleteAction: {}
    )
}
