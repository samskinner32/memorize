//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sam Skinner on 6/17/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  typealias Card = MemoryGame<String>.Card
  
  private static let emojis: [String] = ["🐶", "🦊", "🐻", "🐹","🐱","🐼","🐸","🐵","🐮","🐷","🐰","🐬","🐳","🐯"]
  
  /// Function to generate a memory game with emojis and takes a number of pairs
  /// - Returns: the memory game of emojis model
  private static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairs: 5) { index in
      emojis[index]
    }
  }
  
  @Published private var model = createMemoryGame()
  
  var cards: Array<Card> {
    model.cards
  }
  
  /// Choose a card
  /// - Parameter card: the card you have chosen
  func choose(_ card: Card) {
    model.choose(card)
  }
  
  /// Shuffle the cards on the screen
  func shuffle() {
    model.shuffle()
  }
}
