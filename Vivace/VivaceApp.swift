//
//  VivaceApp.swift
//  Vivace
//
//  Created by Jeremia Reyes on 2/7/21.
//

import SwiftUI

@main
struct VivaceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
