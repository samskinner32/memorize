//
//  MemoryGame.swift
//  Memorize
//
//  Created by Sam Skinner on 6/17/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  private(set) var cards: Array<Card>
  
  // Compute the current face up card when there is only one card face up
  private var indexOfFaceUpCard: Int? {
    let currentFaceUpCards = cards.indices.filter({
      cards[$0].isFaceUp && !cards[$0].isMatched
    })
    return currentFaceUpCards.count == 1 ? currentFaceUpCards.first : nil
  }
  
  /// Initializer for the memory game. Takes a number of pairs and a function to use to create the card content.
  /// Then generates the array of card pairs and returns them shuffled
  /// - Parameters:
  ///   - numberOfPairs: how many pairs of cards for the game
  ///   - createCardContent: how to create the content for the cards for the game
  init(numberOfPairs: Int, createCardContent: (Int) -> CardContent) {
    cards = []
    // add # * 2
    for pairIndex in 0..<numberOfPairs {
      let content: CardContent = createCardContent(pairIndex)
      cards.append(Card(id: pairIndex * 2, content: content))
      cards.append(Card(id: pairIndex * 2 + 1, content: content))
    }
    cards.shuffle()
  }
  
  /// Shuffles the cards array
  mutating func shuffle() {
    cards.shuffle()
  }
  
  /// Choose a card
  /// - Parameter card: the card you have chosen
  mutating func choose(_ card: Card) {
    // If card is matched or already face up, do nothing
    if card.isMatched || card.isFaceUp {
      return
    }

    if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
      // If we have a current face up card, check if we have a match
      if let potentialMaxIndex = indexOfFaceUpCard {
        // If we have a match, set both cards isMatched to true
        if cards[chosenIndex].content == cards[potentialMaxIndex].content {
          cards[chosenIndex].isMatched = true
          cards[potentialMaxIndex].isMatched = true
        }
      } else {
        // If no current card face up, turn all unmatched cards face down first
        for index in cards.indices {
          if !cards[index].isMatched {
            cards[index].isFaceUp = false
          }
        }
      }
      // Flip the selected card
      cards[chosenIndex].isFaceUp = true
    }
  }
  
  /// Card struct that represents a single card. It is identifiable so that the individual views are identifiable when listed
  struct Card: Identifiable {
    let id: Int
    
    var isFaceUp: Bool = true
    var isMatched: Bool = false
    let content: CardContent
  }
}
