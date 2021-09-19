//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Kris Laratta on 8/28/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static func chooseTheme() -> MemoryTheme {
        let themes = [
            MemoryTheme(name: "Vehicles", emojis: ["🚝", "✈️", "🚤", "🛵", "🚘", "🛳", "🚡", "🚞", "🚎", "🚲", "🚁", "🛸"].shuffled(), numberOfPairs: 10, color: "blue"),
            MemoryTheme(name: "Plants", emojis: ["🌵", "🍀", "🌾", "🌲", "🌹", "🌻", "🌴", "🪵", "🌳", "🌱", "🎋", "🍂"].shuffled(), numberOfPairs: 8, color: "green"),
            MemoryTheme(name: "Animals", emojis: ["🦦", "🐉", "🦉", "🦕", "🦑", "🐠", "🐋", "🐢", "🐘", "🐈", "🐿", "🐓", "🐶", "🐫"].shuffled(), numberOfPairs: 14, color: "yellow"),
            MemoryTheme(name: "Space", emojis: ["🪐", "🌖", "🌞", "🌍", "🛰", "🚀"].shuffled(), numberOfPairs: 6, color: "purple"),
            MemoryTheme(name: "Flags", emojis: ["🇺🇸", "🇬🇧", "🇰🇷", "🇹🇷", "🇯🇵", "🇮🇱", "🇨🇳", "🇦🇴", "🏳️‍🌈", "🇬🇷", "🇬🇩", "🇲🇽", "🇮🇹", "🇫🇷"].shuffled(), numberOfPairs: 12, color: "red"),
            MemoryTheme(name: "Food", emojis: ["🥨", "🧀", "🍗", "🍟", "🍕", "🌮", "🥖", "🌽", "🥪", "🫐", "🥟", "🥗"].shuffled(), numberOfPairs: 10, color: "orange")
        ]
        let theme = themes.randomElement() ?? themes[0]
        return theme
    }
    
    private static func createMemoryGame(theme: MemoryTheme) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    @Published private var theme: MemoryTheme
    @Published private var model: MemoryGame<String>
    
    init() {
        let chosenTheme: MemoryTheme = EmojiMemoryGame.chooseTheme()
        self.theme = chosenTheme
        self.model = EmojiMemoryGame.createMemoryGame(theme: chosenTheme)
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    var name: String {
        theme.name
    }
    
    var score: Int {
        model.score
    }
    
    var color: Color {
        let colorString: String = theme.color
        switch colorString {
        case "purple":
            return Color.purple
        case "green":
            return Color.green
        case "yellow":
            return Color.yellow
        case "blue":
            return Color.blue
        case "red":
            return Color.red
        case "orange":
            return Color.orange
        default:
            return Color.white
        }
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        let chosenTheme: MemoryTheme = EmojiMemoryGame.chooseTheme()
        self.theme = chosenTheme
        self.model = EmojiMemoryGame.createMemoryGame(theme: chosenTheme)
    }
}
