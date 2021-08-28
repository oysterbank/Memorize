//
//  ContentView.swift
//  Memorize
//
//  Created by Kris Laratta on 8/1/21.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["🚝", "✈️", "🚤", "🛰", "🚘", "🛳", "🚡", "🚞", "🚎", "🚲", "🚁", "🛸"]
    @State var emojiCount = 12

    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self)  { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.purple)
            Spacer()
            HStack(alignment: .bottom) {
                vehicles
                Spacer()
                animals
                Spacer()
                plants
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var vehicles: some View {
        Button {
            emojis = ["🚝", "✈️", "🚤", "🛰", "🚘", "🛳", "🚡", "🚞", "🚎", "🚲", "🚁", "🛸"].shuffled()
            emojiCount = Int.random(in: 4...emojis.count)
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles")
                    .font(.caption)
            }
        }
        .padding(.horizontal)
    }
    var animals: some View {
        Button {
            emojis = ["🐶", "🐰", "🦊", "🐼", "🐸", "🐦", "🐌", "🐙", "🦆", "🦕", "🐠", "🐒", "🐮", "🐪", "🐋", "🐉"].shuffled()
            emojiCount = Int.random(in: 4...emojis.count)
        } label: {
            VStack {
                Image(systemName: "ladybug")
                Text("Animals")
                    .font(.caption)
            }
        }
        .padding(.horizontal)
    }
    var plants: some View {
        Button {
            emojis = ["🌴", "🌲", "☘️", "💐", "🌾", "🌻", "🌳", "🌵"].shuffled()
            emojiCount = Int.random(in: 4...emojis.count)
        } label: {
            VStack {
                Image(systemName: "leaf")
                Text("Plants")
                    .font(.caption)
            }
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
