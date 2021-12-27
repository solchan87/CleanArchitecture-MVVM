//
//  Pokemon.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/24.
//

import Foundation

struct PokemonList: Decodable {
  let results: [ListedPokemon]
  let count: Int
}

// MARK: - Result
struct ListedPokemon: Decodable {
  let name: String
  let url: String
}
