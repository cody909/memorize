//
//  memorizeApp.swift
//  memorize
//
//  Created by Cody Mercadante on 4/12/22.
//

import SwiftUI

@main
struct memorizeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
