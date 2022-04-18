//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Cody Mercadante on 4/13/22.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    
    private(set) var theme: EmojiMemoryGameTheme.Theme
    @Published private var model: MemoryGame<String>
    
    init(){
        theme = EmojiMemoryGame.selectTheme()
        model = EmojiMemoryGame.createMemoryGame(theme)
    }

    
    static func createMemoryGame(_ theme: EmojiMemoryGameTheme.Theme) -> MemoryGame<String> {
        let randomSelectionOfEmojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs > randomSelectionOfEmojis.count ? randomSelectionOfEmojis.count : theme.numberOfPairs) { pairIndex in
            randomSelectionOfEmojis[pairIndex] }
    }
    
    static func selectTheme() -> EmojiMemoryGameTheme.Theme {
        return EmojiMemoryGameTheme.themes.randomElement()!
    }

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
        self.theme = EmojiMemoryGame.selectTheme()
        model = EmojiMemoryGame.createMemoryGame(self.theme)
    }
}
