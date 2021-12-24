//
//  PokemonAPI.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/24.
//

import Foundation

import Moya

enum WtableV2API {
  case pokemons(offset: Int, limit: Int)
}

extension WtableV2API: TargetType {
  
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
    default:
      return .requestParameters(
        parameters: [:],
        encoding: URLEncoding.default
      )
    }
  }

  var headers: [String: String]? {
    return ["Accept": "application/json"]
  }
}
