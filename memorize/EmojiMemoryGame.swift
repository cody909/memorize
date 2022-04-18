//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Cody Mercadante on 4/13/22.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    
    static private(set) var theme: EmojiMemoryGameTheme.Theme = EmojiMemoryGameTheme.themes.randomElement()!
    @Published var themeName = theme.name
    @Published var themeColor = theme.color

    static func createMemoryGame() -> MemoryGame<String> {
        let randomSelectionOfEmojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs > randomSelectionOfEmojis.count ? randomSelectionOfEmojis.count : theme.numberOfPairs) { pairIndex in
            randomSelectionOfEmojis[pairIndex] }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    
    // MARK: - Intent(s)
    
    func choose (_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame () {
        EmojiMemoryGame.theme = EmojiMemoryGameTheme.themes.randomElement()!
        themeName = EmojiMemoryGame.theme.name
        model = EmojiMemoryGame.createMemoryGame()
    }
}
