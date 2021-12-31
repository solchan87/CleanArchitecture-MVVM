//
//  ServiceProvider.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/21.
//

import Foundation

protocol ServicesProviderType: AnyObject {
  var pokemonService: PokemonServiceType { get }
}

final class ServicesProvider: ServicesProviderType {
  lazy var pokemonService: PokemonServiceType = PokemonService(
    provider: self,
    networking: .init()
  )
}
