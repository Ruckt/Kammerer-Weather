//
//  CodeLoader.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/15/24.
//

import Foundation

struct CodeLoader {
    
    func getCodes() -> [(String, String)] {
        if let path = Bundle.main.path(forResource: "CountryCodes", ofType: "csv") {
            let codes = loadCSV(from: path)
            return codes
        } else {
            return []
        }
    }
    func loadCSV(from filePath: String) -> [(String, String)] {
        var results: [(String, String)] = []

        do {
            let data = try String(contentsOfFile: filePath, encoding: .utf8)
            let rows = data.components(separatedBy: "\n")

            for row in rows {
                let columns = row.components(separatedBy: ",")
                if columns.count == 2 {
                    results.append((columns[0], columns[1]))
                }
            }
        } catch {
            print("Error reading the file: \(error)")
        }

        return results
    }
}
