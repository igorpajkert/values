//
//  Value.swift
//  Values
//
//  Created by Igor Pajkert on 30/05/2025.
//

import Foundation

struct Value: Identifiable, Equatable, Hashable, Codable {
        
    let name: String
    
    var id: String { name }
}
