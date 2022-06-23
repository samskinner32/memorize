//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Sam Skinner on 6/16/22.
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
