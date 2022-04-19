//
//  Theme.swift
//  memorize
//
//  Created by Cody Mercadante on 4/14/22.
//

import Foundation

struct EmojiMemoryGameTheme {
    
    struct Theme {
        let name: String
        let emojis: [String]
        let color: String
        let numberOfPairs: Int
    }

    static var themes: [Theme] = [
        Theme(name: "Animals", emojis: ["🐶","🐯","🐸","🐝"], color: "green", numberOfPairs: 4),
        Theme(name: "Sports", emojis: ["⚽️","🏀","🏈","⚾️"], color: "red", numberOfPairs: 8),
        Theme(name: "Halloween", emojis: ["🕷","🕸","🎃","🦇"], color: "orange", numberOfPairs: 4)
    ]
}
