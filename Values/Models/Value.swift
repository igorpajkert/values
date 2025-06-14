//
//  Value.swift
//  Values
//
//  Created by Igor Pajkert on 30/05/2025.
//

import Foundation

struct Value: Identifiable, Equatable, Hashable, Codable {
    
    let en: String
    let pl: String
    
    var name: String {
        let language = Bundle.main.preferredLocalizations[0]
        return language == "pl" ? pl : en
    }
    
    var id: String { name }
}
