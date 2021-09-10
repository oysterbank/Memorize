//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Kris Laratta on 8/1/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
