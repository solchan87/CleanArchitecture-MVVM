//
//  PokemonAPI.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/24.
//

import Foundation

import Moya

enum PokemonAPI {
  case pokemons(offset: Int, limit: Int)
}

extension PokemonAPI: TargetType {
  
  var baseURL: URL {
    URL(string: "https://pokeapi.co/api/v2")!
  }
  
  var path: String {
    switch self {
    case .pokemons:
      return "/pokemons"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case
      .pokemons
    :
      return .get
    }
  }
  
  var task: Task {
    switch self {
    case let .pokemons(offset, limit):
      return .requestParameters(
        parameters: [
          "offset": offset,
          "limit": limit
        ],
        encoding: URLEncoding.default
      )
    }
  }

  var headers: [String: String]? {
    return ["Accept": "application/json"]
  }
}
