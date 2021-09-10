//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Kris Laratta on 8/1/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame

    var body: some View {
        VStack {
            Text(game.name)
                .font(.largeTitle)
                .padding(.top)
                .foregroundColor(game.color)
            Spacer()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 64))]) {
                ForEach(game.cards)  { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            .foregroundColor(game.color)
            .padding(.horizontal)
            Spacer()
            HStack {
                Text("Score: \(game.score)")
                Spacer()
                Button(action: game.startNewGame, label: {
                    Text("New Game")
                })
            }
            .padding([.top, .leading, .trailing])
        }
        
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
