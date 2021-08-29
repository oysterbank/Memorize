//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Kris Laratta on 8/28/21.
//

import SwiftUI

class EmojiMemoryGame {
    static let emojis = ["🚝", "✈️", "🚤", "🛰", "🚘", "🛳", "🚡", "🚞", "🚎", "🚲", "🚁", "🛸"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
