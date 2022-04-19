//
//  EmojiMemoryGameView.swift
//  memorize
//
//  Created by Cody Mercadante on 4/12/22.
//

import SwiftUI
import CoreData

struct EmojiMemoryGameView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            header()
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            .foregroundColor(.red)
            Spacer()
            
            newGameButton()
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        Text(game.theme.name).font(.largeTitle)
        Text("Score: \(game.score)")
    }
    
    //    @ViewBuilder
    //    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
    //        if card.isMatched && !card.isFaceUp {
    //            Rectangle().opacity(0)
    //        } else {
    //            CardView(card: card)
    //                .padding(4)
    //                .onTapGesture {
    //                    game.choose(card)
    //                }
    //        }
    //    }
    
    @ViewBuilder
    private func newGameButton() -> some View {
        Button {
            game.newGame()
        } label: {
            Text("New Game")
        }
        .padding(.horizontal)
    }
    
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
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
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
        EmojiMemoryGameView(game: game).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.light)
    }
}
