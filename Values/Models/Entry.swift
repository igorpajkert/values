//
//  Entry.swift
//  Values
//
//  Created by Igor Pajkert on 30/05/2025.
//

import Foundation

@Observable
final class Entry: Identifiable, Codable {
    
    let id: UUID
    var values: [Value] {
        didSet {
            dateModified = .now
        }
    }
    let dateCreated: Date
    var dateModified: Date
    var isPicked: Bool
    
    init(
        id: UUID = UUID(),
        values: [Value],
        dateCreated: Date = .now,
        dateModified: Date = .now,
        isPicked: Bool = false
    ) {
        self.id = id
        self.values = values
        self.dateCreated = dateCreated
        self.dateModified = dateModified
        self.isPicked = isPicked
    }
    
    func move(from source: IndexSet, to newIndex: Int) {
        values.move(fromOffsets: source, toOffset: newIndex)
        dateModified = .now
    }
}

extension Entry: Equatable, Hashable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        lhs.id == rhs.id &&
        lhs.values == rhs.values &&
        lhs.dateCreated == rhs.dateCreated &&
        lhs.dateModified == rhs.dateModified
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
