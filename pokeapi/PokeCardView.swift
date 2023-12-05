//
//  PokeCardView.swift
//  pokeapi
//
//  Created by Shreeram Kelkar on 13/11/23.
//

import SwiftUI

struct PokeCardView: View {
    var pokemon: Pokemon

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(0.24))
                .cornerRadius(8)
            
            VStack(spacing: 4) {
                AsyncImage(url: URL(string: "https://neopentane.xyz/sprites/sprites/pokemon/" + (getPokemonNumber(from: pokemon.url) ?? "1") + ".png")) { image in  // <-- here
                    image.resizable()
                } placeholder: {
                    ProgressView().progressViewStyle(.circular)
                }.frame(height: 100)

//                
//                Text(pokemon.name)
//                    .foregroundStyle(.white)
//                    .frame(height: 50)
                
                Button {
                    print("sd")
                } label: {
                    Text(pokemon.name)
                        .foregroundStyle(.white)
                        .font(.footnote)
                }
                .padding(4)
                .background(Color(red: 0.78, green: 0.49, blue: 0.31))
                .cornerRadius(8)


            }
        }

    }
}

//#Preview {
//    PokeCardView()
//}
