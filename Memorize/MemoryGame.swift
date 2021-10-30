//
//  MemoryGame.swift
//  Memorize
//
//  Created by Kris Laratta on 8/28/21.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private(set) var score: Int
    
    private var indexOfTheOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).only }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    if cards[potentialMatchIndex].seen {
                        score -= 1
                    } else {
                        cards[potentialMatchIndex].seen = true
                    }
                    if cards[chosenIndex].seen {
                        score -= 1
                    } else {
                        cards[chosenIndex].seen = true
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
//            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        score = 0
        cards = []
        // Add numberOfPairsOfCards * 2 to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var seen = false
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        let id: Int
        
        // MARK: - Bonus Time
        
        // This can be 0, which means there is no bonus available for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // How long this card has ever been up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // The last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        // The accumulated time this card has been face up in the past
        // Not including the current time it's been face up if it is currently so
        var pastFaceUpTime: TimeInterval = 0
        
        // How much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // Percentage of bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        // Was the card was matched during the bonus period?
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // Is the card face up and unmatched, but has yet to use up the bonus window?
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // Called when the card transitions to a face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // Called when the card goes back to face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}

extension Array {
    var only: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
