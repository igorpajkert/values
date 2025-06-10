//
//  Store.swift
//  Values
//
//  Created by Igor Pajkert on 30/05/2025.
//

import SwiftUI

@Observable
final class Store {
    
    var entries: [Entry]
    var values: [Value] = load("data.json")
    
    var selectedEntry: Entry? {
        didSet {
            resetPicker()
        }
    }
    var entryToDelete: Entry?
    var isShowingDeleteAlert = false
    
    var selectedValues = [Value]()
    var remainingValues = [Value]()
    var selectedValuesCount = 0
    var selectionPhase = ValuesSelectionPhase.ongoing
    
    init(
        entries: [Entry] = []
    ) {
        self.entries = entries
        
        remainingValues = getRemainingValues()
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent("entries.data")
    }
    
    func loadEntries() async throws {
        let task = Task<[Entry], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else { return [] }
            let entries = try JSONDecoder().decode([Entry].self, from: data)
            return entries
        }
        let entries = try await task.value
        self.entries = entries
    }
    
    func saveEntries() async throws {
        let task = Task {
            let data = try JSONEncoder().encode(entries)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    // MARK: - Intents
    func addEntry() {
        let entry = Entry(values: values, dateModified: .now)
        
        withAnimation {
            entries.append(entry)
        }
    }
    
    func selectEntry(_ entry: Entry) {
        selectedEntry = entry
    }
    
    func deleteEntry() {
        guard let entryToDelete else { return }
        
        withAnimation {
            entries.removeAll { $0.id == entryToDelete.id }
        }
    }
    
    func markToDelete(_ entry: Entry) {
        entryToDelete = entry
        isShowingDeleteAlert = true
    }
    
    func moveValues(from source: IndexSet, to destination: Int) {
        selectedEntry?.move(from: source, to: destination)
    }
    
    func getIndex(of value: Value) -> Int {
        selectedValues.firstIndex(of: value) ?? 0
    }
    
    func selectValue(_ value: Value) {
        guard selectedValuesCount < 10 else { return }
        
        if selectedValues.contains(value) {
            selectedValues.removeAll { $0.id == value.id }
            
            selectedValuesCount -= 1
            if selectedValuesCount < 10 {
                withAnimation {
                    selectionPhase = .ongoing
                }
            }
        } else {
            selectedValues.append(value)
            
            selectedValuesCount += 1
            if selectedValuesCount == 10 {
                withAnimation {
                    selectionPhase = .finished
                    
                    if getRemainingValues().isEmpty {
                        selectionPhase = .ended
                        selectedEntry?.isPicked = true
                        selectedEntry?.values = selectedValues.reversed()
                    }
                }
            }
        }
    }
    
    func isValueSelected(_ value: Value) -> Bool {
        selectedValues.contains(value)
    }
    
    func getRemainingValues() -> [Value] {
        values.filter { !selectedValues.contains($0) }
    }
    
    func nextPhase() {
        withAnimation {
            selectedValuesCount = 0
            remainingValues = getRemainingValues()
            selectionPhase = .ongoing
        }
    }
    
    func resetPicker() {
        selectedValuesCount = 0
        selectedValues.removeAll()
        remainingValues = getRemainingValues()
        selectionPhase = .ongoing
    }
}

extension EnvironmentValues {
    @Entry var store = Store()
}

extension View {
    func store(_ store: Store) -> some View {
        environment(\.store, store)
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

enum ValuesSelectionPhase {
    case ongoing
    case finished
    case ended
}
