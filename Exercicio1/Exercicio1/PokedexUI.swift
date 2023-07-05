//
//  PokedexUI.swift
//  Exercicio1
//
//  Created by Filipe Bravo on 30/05/2023.
//

import Foundation
import SwiftUI

//Questionar o prof, qual seria mais eficiente e mais correto
/*
 func backgroundColor(for pokemon: Pokemon) -> Color {
    guard let type = pokemon.types.first else {
        return Color.gray
    }
    
    switch type.type.name {
    case "normal":
        return Color("normal")
    case "fire":
        return Color("fire")
    case "water":
        return Color("water")
    case "electric":
        return Color("electric")
    case "grass":
        return Color("grass")
    case "ice":
        return Color("ice")
    case "fighting":
        return Color("fighting")
    case "poison":
        return Color("poison")
    case "ground":
        return Color("ground")
    case "flying":
        return Color("flying")
    case "psychic":
        return Color("psychic")
    case "bug":
        return Color("bug")
    case "rock":
        return Color("rock")
    case "ghost":
        return Color("ghost")
    case "dragon":
        return Color("dragon")
    case "dark":
        return Color("dark")
    case "steel":
        return Color("steel")
    case "fairy":
        return Color("fairy")
    default:
        return Color.gray
    }
}
*/

func getColorStatBar(stat:String) -> Color {
    if stat == "hp"{
        return .green
    } else if stat == "attack" || stat == "special-attack" {
        return .red
    } else if stat == "defense" || stat == "special-defense"{
        return .blue
    } else if stat == "speed"{
        return .orange
    } else {
        return .gray
    }
}
