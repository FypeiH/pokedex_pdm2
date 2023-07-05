//
//  PokedexAPI.swift
//  Exercicio1
//
//  Created by Filipe Bravo on 17/05/2023.
//

import Foundation

struct NamedAPIResource<T>: Codable{
    var name:String
    var url:String
}

struct NamedAPIResourceList<T>: Codable{
    var next:String?
    var results:[NamedAPIResource<T>]
}

struct PokemonSprites: Codable{
    var front_default:String
}

struct PokemonStat: Identifiable, Codable{
    var id: UUID {UUID()}
    var stat: NamedAPIResource<Stat>
    var effort: Int
    var base_stat: Int
}

struct PokemonType: Identifiable, Codable{
    var id:Int {slot}
    var slot:Int
    var type:NamedAPIResource<Type>
}

struct Stat: Identifiable, Codable{
    var id:Int
    var name:String
    
}

struct Type: Identifiable, Codable{
    var id:Int
    var name:String
}

struct Pokemon: Identifiable, Codable{
    var id:Int
    var name:String
    var height:Int
    var weight:Int
    var sprites:PokemonSprites
    var stats:[PokemonStat]
    var types:[PokemonType]
}


class loadData: ObservableObject {
    
    var baseURL:URL = URL(string: "https://pokeapi.co/api/v2")!
    var currentPageURL:URL?
    var hasMorePages:Bool {
        return currentPageURL != nil
    }
    
    @Published var allPokemon:[Pokemon] = []
    @Published var displayedPokemon:[Pokemon] = []
    
    
    //Vai bucar os Pokemons da página inicial e inicializa as propriedades currentPageURL, displayedPokemon e allPokemon
    func fetchPokemon() async throws {
        //Adiciona o componente pokemon ao URL base da API
        currentPageURL = baseURL.appendingPathComponent("pokemon")
        print(currentPageURL!)
        
        //Reseta os arrays displayedPokemon, allPokemon
        displayedPokemon = []
        allPokemon = []
        
        //Vai buscar a próxima página de dados de Pokemons
        try await fetchNextPage()
    }
    
    
    //Vai buscar a próxima pagina de dados de Pokemons e atualiza os array allPokemon e displayedPokemon
    func fetchNextPage() async throws {
        guard let url = currentPageURL else {
            return
        }
        
        //Vai buscar os dados dos Pokemons da página atual
        let pagePokemon = try await fetchPokemonData(from: url)
        
        //Dá append ao array allPokemon dos Pokemons que acabaram de ser carregados
        allPokemon.append(contentsOf: pagePokemon)
        
        //Atualiza o array displayedPokemon ao adicionar mais 30 Pokemons para a lista de Pokemons já carregados
        displayedPokemon = Array(allPokemon.prefix(displayedPokemon.count + 30))
        
        //Vai buscar a próxima página, se houver
        if let nextPageUrl = try await fetchPokemonPage(url: url) {
            currentPageURL = nextPageUrl
        } else {
            currentPageURL = nil
        }
    }
    
   
    //Vai buscar uma página de dados de Pokemons pelo URL fornecido e retorna o URL da próxima página, se houver
    func fetchPokemonPage(url: URL) async throws -> URL? {
        //Faz o pedido para ir buscar os dados dos Pokemons do URL fornecido
        let (data, _) = try await URLSession.shared.data(from: url)
        
        //Descodifica a resposta para o objeto NamedAPIResourceList
        let response = try JSONDecoder().decode(NamedAPIResourceList<Pokemon>.self, from: data)
        
        //Extrai e retorna o URL da próxima página, se houver
        return URL(string: response.next ?? "")
    }
    
    

    //Vai buscar os dados dos Pokemons do URL fornecido e retorna um array de Pokemons
    func fetchPokemonData(from url: URL) async throws -> [Pokemon] {
        //Faz um pedido para buscar os dados do Pokemon do URL fornecido
        let (data, _) = try await URLSession.shared.data(from: url)
        
        //Descodifica a resposta para o objeto NamedAPIResourceList
        let response = try JSONDecoder().decode(NamedAPIResourceList<Pokemon>.self, from: data)
        
        var pokemonArray: [Pokemon] = []
        
        //Repete sobre cada named resource na resposta
        for namedResource in response.results {
            //Vai buscar os dados do Pokemon do URL individual do mesmo
            let pokemonURL:URL = URL(string: namedResource.url)!
            let pokemonData:Pokemon = try await loadDataAsyncNamedAPIResource(url: pokemonURL)
            
            //Extrai os dados da imagem, dos stats e dos tipos dos dados recolhidos do Pokemon
            let spritesData:PokemonSprites = pokemonData.sprites
            let statsData:[PokemonStat] = pokemonData.stats
            let typeList:[PokemonType] = pokemonData.types
            
            //Cria um objeto Pokemon com os dados recolhidos e adiciona o objeto a um array de Pokemons
            let pokemon = Pokemon(id: pokemonData.id, name: pokemonData.name, height: pokemonData.height, weight: pokemonData.weight, sprites: spritesData, stats:statsData, types: typeList)
            pokemonArray.append(pokemon)
        }
        
        return pokemonArray
    }
    
    //Carrega assincronamente um named resource da API a partir do URL fornecido
    func loadDataAsyncNamedAPIResource<T: Decodable>(url:URL) async throws -> T{
        //Faz um pedido para buscar os dados do URL fornecido
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decodifica os dados em um objeto do tipo genérico `T`
        let resource = try JSONDecoder().decode(T.self, from: data)
        
        //Retorna o resource da API carregado
        return resource
    }
    
}

