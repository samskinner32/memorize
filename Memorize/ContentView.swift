//
//  ContentView.swift
//  Memorize
//
//  Created by Sam Skinner on 6/16/22.
//

import SwiftUI

struct ContentView: View {
  @State private var emojis: [String] = ["🐶", "🦊", "🐻", "🐹","🐱","🐼","🐸","🐵","🐮","🐷","🐰","🐬","🐳","🐯"]
  @State private var numberToShow = 6 // total count 14
  
  var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
          ForEach(emojis[0..<numberToShow], id: \.self) { emoji in
            CardView(emoji: emoji)
          }
        }
        .foregroundColor(.red)
      }
      Spacer()
      HStack {
        removeButton
        Spacer()
        shuffleButton
        Spacer()
        addButton
      }
      .font(.largeTitle)
      .padding(.top)
    }
    .padding()
  }
  
  var removeButton: some View {
    Button(action: {
      if (numberToShow > 1) {
        numberToShow -= 1
      }
    }) {
      Image(systemName: "minus.circle")
    }
  }
  
  var addButton: some View {
    Button(action: {
      if (numberToShow < emojis.count) {
        numberToShow += 1
      }
      
    }) {
      Image(systemName: "plus.circle")
    }
  }
  
  var shuffleButton: some View {
    Button(action: {
      withAnimation {
        emojis.shuffle()
      }
    }) {
      Text("Shuffle")
    }
  }
}

struct CardView: View {
  @State private var isFaceUp = false
  var emoji: String
  var body: some View {
    let shape = RoundedRectangle(cornerRadius: 14)
    ZStack {
      if isFaceUp {
        shape.foregroundColor(.white)
        shape.strokeBorder(lineWidth: 3)
        Text(emoji).font(.largeTitle)
      } else {
        shape
      }
    }
    .aspectRatio(2/3, contentMode: .fit)
    .onTapGesture {
      withAnimation {
        isFaceUp.toggle()
      }
    }
  }
}






struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.dark)
      .previewDevice("iPhone 13 Pro")
    ContentView()
      .previewDevice("iPhone 13 Pro")
    ContentView()
      .preferredColorScheme(.dark)
      .previewDevice("iPhone 13 Pro")
      .previewInterfaceOrientation(.landscapeLeft)
    ContentView()
      .previewDevice("iPhone 13 Pro")
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
