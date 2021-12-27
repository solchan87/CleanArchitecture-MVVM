//
//  PokemonService.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/27.
//

import RxSwift

protocol PokemonServiceType: AnyObject {
  func getPokemonList(offset: Int, limit: Int) -> Single<PokemonList>
}

class PokemonService: BaseService, PokemonServiceType {
  
  private let networking: Networking
  
  init(provider: ServicesProviderType, networking: Networking) {
    self.networking = networking
    super.init(provider: provider)
  }
  
  func getPokemonList(offset: Int, limit: Int) -> Single<PokemonList> {
    return self.networking.request(
      .target(
        PokemonAPI.pokemons(
          offset: offset,
          limit: limit
        )
      )
    ).map(PokemonList.self)
  }
}
