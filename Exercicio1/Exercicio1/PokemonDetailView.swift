//
//  PokemonDetailView.swift
//  Exercicio1
//
//  Created by Filipe Bravo on 05/06/2023.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView{
            ZStack {
                Color("\(pokemon.types.first!.type.name)")

                VStack{
                    AsyncImage(url: URL(string: pokemon.sprites.front_default),
                                   content: { image in
                                       image.resizable()
                                   },
                                   placeholder: {
                                       ProgressView()
                                   })
                    .frame(width: 250, height: 250)
                    HStack(){
                        Spacer()
                        
                        VStack(alignment: .center){
                            Grid(alignment: .bottom, verticalSpacing:20){
                                GridRow{
                                    HStack{
                                        Text("\(pokemon.id)")
                                            .foregroundColor(.gray.opacity(0.5))
                                        Text("\(pokemon.name.capitalized)")
                                            .font(.system(size: 25, weight: .bold, design: .rounded))
                                    }
                                    
                                }
                                GridRow{
                                    HStack{
                                        ForEach(pokemon.types) { poketype in
                                            Text("\(poketype.type.name.capitalized)")
                                            .padding([.trailing, .leading], 30)
                                            .padding([.bottom, .top], 10)
                                            .foregroundColor(.white)
                                            .background(Color("\(poketype.type.name)"))
                                            .cornerRadius(50)
                                        }
                                    }
                                }
                                GridRow{
                                    HStack{
                                        VStack{
                                            Text("\(pokemon.height*10) cm")
                                            Text("Height")
                                                .foregroundColor(.gray)
                                        }
                                        .padding([.trailing, .leading], 30)
                                        .padding([.bottom, .top], 10)
                                        Divider()
                                        VStack{
                                            Text("\(pokemon.weight) lbs")
                                            Text("Weight")
                                                .foregroundColor(.gray)
                                        }
                                        .padding([.trailing, .leading], 30)
                                        .padding([.bottom, .top], 10)
                                    }
                                    .fixedSize(horizontal: false, vertical: true)
                                }
                                
                                GridRow{
                                    Text("Base Stats")
                                        .font(.headline)
                                }
                                GridRow{
                                    Grid(alignment: .leading, horizontalSpacing: 10){
                                        ForEach(pokemon.stats) { pokestats in
                                            GridRow{
                                                
                                                if pokestats.stat.name == "hp"{
                                                    Text("HP")
                                                        .foregroundColor(.gray)
                                                } else if pokestats.stat.name == "attack"{
                                                    Text("ATK")
                                                        .foregroundColor(.gray)
                                                } else if pokestats.stat.name == "defense"{
                                                    Text("DEF")
                                                        .foregroundColor(.gray)
                                                } else if pokestats.stat.name == "special-attack"{
                                                    Text("S.ATK")
                                                        .foregroundColor(.gray)
                                                } else if pokestats.stat.name == "special-defense"{
                                                    Text("S.DEF")
                                                        .foregroundColor(.gray)
                                                } else if pokestats.stat.name == "speed"{
                                                    Text("SPD")
                                                        .foregroundColor(.gray)
                                                }
                                                Text("\(pokestats.base_stat)")
                                                ZStack(alignment: .leading){
                                                    Rectangle()
                                                        .frame(width: 200, height: 20)
                                                        .foregroundColor(.gray.opacity(0.1))
                                                    Rectangle()
                                                        .frame(width:CGFloat(pokestats.base_stat))
                                                        .foregroundColor(getColorStatBar(stat: pokestats.stat.name))
                                                 }
                                                 .frame(width: 200, height: 20)
                                                 .cornerRadius(5)
                                                
                                            }
                                            
                                            
                                        }
                                    }
                                }
                                
                                
                                
                            }
                            .padding()
                            
                            Spacer()
                        }
                        .padding(25)
                        
                        Spacer()
                    }
                    .background(.white)
                    .cornerRadius(30)
                    Spacer()
                }
            }
            
        }
        .background(Color("\(pokemon.types.first!.type.name)"))
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon(id: 1, name: "Bulbasaur", height: 12, weight: 13, sprites: PokemonSprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), stats: [PokemonStat(stat: NamedAPIResource(name: "hp", url: "nil"), effort: 98, base_stat: 20),PokemonStat(stat: NamedAPIResource(name: "attack", url: "nil"), effort: 98, base_stat: 20),PokemonStat(stat: NamedAPIResource(name: "defense", url: "nil"), effort: 98, base_stat: 20),PokemonStat(stat: NamedAPIResource(name: "special-attack", url: "nil"), effort: 98, base_stat: 20),PokemonStat(stat: NamedAPIResource(name: "special-defense", url: "nil"), effort: 98, base_stat: 20),PokemonStat(stat: NamedAPIResource(name: "speed", url: "nil"), effort: 98, base_stat: 20)],types: [PokemonType(slot: 1, type: NamedAPIResource(name: "grass", url: ""))]))
    }
}
