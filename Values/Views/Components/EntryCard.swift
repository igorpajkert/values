//
//  EntryCard.swift
//  Values
//
//  Created by Igor Pajkert on 03/06/2025.
//

import SwiftUI

struct EntryCard: View {
    
    let dateCreated: Date
    let dateModified: Date
    let action: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                textDateCreated
                Divider()
                textDateModified
            }
            Spacer()
            buttonAction
        }
        .padding()
    }
    
    private var textDateCreated: some View {
        Text(dateCreated, format: .dateTime.day().month().year().hour().minute())
            .font(.title)
    }
    
    private var textDateModified: some View {
        Text("text.lastModified: \(dateModified.formatted(.dateTime.day().month().year().hour().minute()))")
    }
    
    private var buttonAction: some View {
        Button(action: action) {
            Image(systemName: "chevron.right")
                .font(.title)
                .imageScale(.large)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.circle)
        .padding()
    }
}

#Preview {
    EntryCard(dateCreated: .distantPast, dateModified: .now, action: {})
}
