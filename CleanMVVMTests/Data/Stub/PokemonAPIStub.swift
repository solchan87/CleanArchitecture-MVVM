//
//  PokemonAPIStub.swift
//  CleanMVVMTests
//
//  Created by Tom on 2022/01/20.
//

import Foundation
@testable import CleanMVVM

extension PokemonAPI {
  var sampleData: Data {
    switch self {
    case .pokemons:
      return getJSONData(fileName: "PokemonListMock")
    }
  }
}
