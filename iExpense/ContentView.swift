//
//  ContentView.swift
//  iExpense
//
//  Created by David Ash on 10/07/2023.
//

import SwiftUI

struct ExpenseDetailView: View {
    let name: String
    let type: String
    let amount: Double
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(type)
            }
            
            Spacer()
            
            Text(amount,
                 format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            .font(amount < 10 ? .body : .body.bold())
            .foregroundColor(amount > 100 ? .red : .black)
        }
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                
                if expenses.personalItems.count > 0 {
                    Section("Personal expenses") {
                        ForEach(expenses.personalItems) { item in
                            ExpenseDetailView(name: item.name, type: item.type, amount: item.amount)
                        }
                        .onDelete(perform: removePersonalItems)
                    }
                }
                
                if expenses.businessItems.count > 0 {
                    Section("Business expenses") {
                        ForEach(expenses.businessItems) { item in
                            ExpenseDetailView(name: item.name, type: item.type, amount: item.amount)
                        }
                        .onDelete(perform: removeBusinessItems)
                    }
                }
                
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(
                where: { $0.id == expenses.personalItems[offset].id }) {
                expenses.items.remove(at: index)
            }
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(
                where: { $0.id == expenses.businessItems[offset].id }) {
                expenses.items.remove(at: index)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
