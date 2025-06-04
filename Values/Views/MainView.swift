//
//  MainView.swift
//  Values
//
//  Created by Igor Pajkert on 31/05/2025.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.store) private var store
    @Environment(\.scenePhase) private var scenePhase
    
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack {
            EntriesView()
                .onChange(of: scenePhase) { old, new in
                    if new == .inactive {
                        saveAction()
                    }
                }
        }
    }
}

#Preview {
    MainView(saveAction: {})
        .environment(\.store, Store())
}
