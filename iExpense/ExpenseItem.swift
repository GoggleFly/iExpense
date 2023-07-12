//
//  ExpenseItem.swift
//  iExpense
//
//  Created by David Ash on 12/07/2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
