//
//  MoneyManagement_AppApp.swift
//  MoneyManagement App
//
//  Created by Raquel on 10/10/24.
//

import SwiftUI

@main
struct MoneyManagement_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
