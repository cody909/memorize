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
        Theme(name: "Animals", emojis: ["πΆ","π―","πΈ","π"], color: "green", numberOfPairs: 4),
        Theme(name: "Sports", emojis: ["β½οΈ","π","π","βΎοΈ"], color: "red", numberOfPairs: 8),
        Theme(name: "Halloween", emojis: ["π·","πΈ","π","π¦"], color: "orange", numberOfPairs: 4)
    ]
}
