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
    let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
