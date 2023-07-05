//
//  PokemonGridItem.swift
//  Exercicio1
//
//  Created by Filipe Bravo on 05/06/2023.
//

import SwiftUI

struct PokemonGridItem: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.sprites.front_default))
                .frame(width: 100, height: 100)
            
            Text("\(pokemon.name.capitalized)")
                .font(.headline)
        }
        .frame(width: 150, height: 150)
        .padding(10)
        .background(Color("\(pokemon.types.first!.type.name)"))
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}
