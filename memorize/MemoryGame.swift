//
//  MemoryGame.swift
//  memorize
//
//  Created by Cody Mercadante on 4/13/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private(set) var score = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
                                
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard { // another card is already flipped
                checkForMatch(chosenIndex, potentialMatchIndex)
                cards[chosenIndex].seenBefore = true
                cards[potentialMatchIndex].seenBefore = true
                cards[chosenIndex].isFaceUp = true
            }  else { // no other card us flipped
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    /// Checks is the content of two cards match and adds 2 to the score if they do;
    /// else if the content does not match at leat one of the cards has been flipped before subtracts 1 from the score.
    /// - Parameters:
    ///   - firstCardIndex: the index of the first card turned over
    ///   - secondCardIndex: the index of the second card turned over
    private mutating func checkForMatch(_ firstCardIndex: Int, _ secondCardIndex: Int){
        if cards[firstCardIndex].content == cards[secondCardIndex].content { // cards match
            cards[firstCardIndex].isMatched = true
            cards[secondCardIndex].isMatched = true
            score += 2
        } else { // cards do not match
            if cards[firstCardIndex].seenBefore || cards[secondCardIndex].seenBefore {
                score -= 1
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var seenBefore = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

