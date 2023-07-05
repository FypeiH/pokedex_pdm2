//
//  ContentView.swift
//  Exercicio1
//
//  Created by Aluno ISTEC on 06/05/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var load = loadData()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(load.allPokemon) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonGridItem(pokemon: pokemon)
                        }
                        .onAppear {
                            // Verifica se o último pokemon da última página carregada foi visto para carregar a página a seguir
                            if load.hasMorePages && pokemon.id == load.displayedPokemon.last?.id {
                                Task {
                                    do {
                                        try await load.fetchNextPage()
                                    } catch {
                                        print("Error fetching next page of Pokemon: \(error)")
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle("Pokedex")
            }
            .onAppear{
                Task{
                    do{
                        try await load.fetchPokemon()
                    }catch{
                        print("Error fetching Pokemon: \(error)")
                    }
                    
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

