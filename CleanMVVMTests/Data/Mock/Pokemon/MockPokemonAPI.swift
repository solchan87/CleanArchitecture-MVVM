//
//  File.swift
//  CleanMVVMTests
//
//  Created by Tom on 2021/12/27.
//

import Foundation

@testable import CleanMVVM

extension PokemonAPI {
  var sampleData: Data {
    switch self {
    case .pokemons:
      guard
        let url = Bundle.main.url(forResource: "PokemonListJSON", withExtension: "json"),
        let data = try? Data(contentsOf: url)
      else {
        return .init()
      }
      return data
    }
  }
}
