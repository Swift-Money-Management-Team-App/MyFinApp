//
//  ContentView.swift
//  MoneyManagement App
//
//  Created by Raquel on 10/10/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let vm : ContentViewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: vm.deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: vm.addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
