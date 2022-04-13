//
//  ContentView.swift
//  memorize
//
//  Created by Cody Mercadante on 4/12/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    let themes = [
        "vehicles": ["🚂", "🚀", "🚁", "🚜"],
        "animals": ["🐢", "🐧", "🐵", "🦑"],
        "flags": ["🇺🇸", "🇸🇪", "🇹🇻", "🇺🇦"]
    ]
    
    @State var emojis = ["🚂", "🚀", "🚁", "🚜"]
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojis.count], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.red)
            }
            
            Spacer()
            
            HStack {
                selectVehicleTheme
                Spacer()
                selectFlagTheme
                Spacer()
                selectFruitTheme
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var selectVehicleTheme: some View {
        Button {
                emojis = themes["vehicles"]!.shuffled()
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles").font(.footnote)
            }
        }
    }
    
    var selectFlagTheme: some View {
        Button {
            emojis = themes["flags"]!.shuffled()
        } label: {
            VStack {
                Image(systemName: "flag")
                Text("Flags").font(.footnote)
            }
        }
    }
    
    var selectFruitTheme: some View {
        Button {
            emojis = themes["animals"]!.shuffled()
        } label: {
            VStack{
                Image(systemName: "tortoise")
                Text("Animals").font(.footnote)
            }
        }
    }
    
}

struct CardView: View {
    @State var isFaceUp: Bool = true // creates a pointer to a variable and rebuild the view when a change in state is detected
    
    var content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape
                    .fill()
            }
            
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portrait)
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.light)
    }
}
