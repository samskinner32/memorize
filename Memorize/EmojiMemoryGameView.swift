//
//  ContentView.swift
//  Memorize
//
//  Created by Sam Skinner on 6/16/22.
//

import SwiftUI

/// The main view for the game, shows the list of cards as well as a shuffle button
struct EmojiMemoryGameView: View {
  @ObservedObject var game: EmojiMemoryGame
  
  var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
          ForEach(game.cards) { card in
            CardView(card)
              .aspectRatio(2/3, contentMode: .fit)
              .onTapGesture {
                game.choose(card)
              }
          }
        }
        .foregroundColor(.red)
      }
      Spacer()
      HStack {
        shuffleButton
      }
      .font(.title)
      .padding(.top)
    }
    .padding()
  }
  
  var shuffleButton: some View {
    Button(action: {
      withAnimation {
        game.shuffle()
      }
    }) {
      Text("Shuffle")
        .foregroundColor(.white)
    }
    .padding()
    .background(Capsule()
      .foregroundColor(.blue)
    )
  }
}

/// A card for the game, displays the front or  back of the card based on isFaceUp
struct CardView: View {
  private let card: EmojiMemoryGame.Card
  
  /// Initializes the card with the unnamed parameter and assigning it to card
  /// - Parameter card: the card for this view to represent
  init(_ card: EmojiMemoryGame.Card) {
    self.card = card
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
        if card.isFaceUp {
          shape.foregroundColor(.white)
          shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
          Text(card.content).font(fontSize(in: geometry.size))
        } else {
          shape
        }
      }
    }
  }
  
  /// Takes the geometry size and calculates the font size for the emoji
  /// - Parameter size: geometry size for this card
  /// - Returns: the font size for the emoji
  private func fontSize(in size: CGSize) -> Font {
    Font.system(size: min(size.width, size.height) * DrawingConstants.emojiScale)
  }
  
  private struct DrawingConstants {
    static let cornerRadius: CGFloat = 14
    static let lineWidth: CGFloat = 3
    static let emojiScale: CGFloat = 0.7
  }
}






struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()
    EmojiMemoryGameView(game: game)
      .preferredColorScheme(.dark)
      .previewDevice("iPhone 13 Pro")
    EmojiMemoryGameView(game: game)
      .previewDevice("iPhone 13 Pro")
    EmojiMemoryGameView(game: game)
      .preferredColorScheme(.dark)
      .previewDevice("iPhone 13 Pro")
      .previewInterfaceOrientation(.landscapeLeft)
    EmojiMemoryGameView(game: game)
      .previewDevice("iPhone 13 Pro")
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
