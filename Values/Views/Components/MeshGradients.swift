//
//  MeshGradients.swift
//  Values
//
//  Created by Igor Pajkert on 02/06/2025.
//

import SwiftUI

struct BorderMeshGradient: View {
    
    @State private var wave1 = false
    @State private var wave2 = false
    
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.0, 0.5], wave1 ? [0.5, 0.5] : [0.8, 0.2], [1.0, 0.5],
                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
            ],
            colors: [
                wave2 ? .lightLavender : .lavender, wave1 ? .lightLavender : .lavender, wave2 ? .lavender : .lightLavender,
                wave1 ? .lavender : .accent, .lavender, wave2 ? .accent : .lavender,
                wave1 ? .accent : .darkLavender, wave2 ? .accent : .darkLavender, wave1 ? .darkLavender : .accent
            ]
        )
        .ignoresSafeArea(.all)
        .onAppear {
            withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                wave1.toggle()
            }
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                wave2.toggle()
            }
        }
    }
}

#Preview("Border") {
    BorderMeshGradient()
}
