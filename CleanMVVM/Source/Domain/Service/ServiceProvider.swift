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
  let networking: NetworkingProtocol
  let coreDataStack: CoreDataStack
  
  init(
    networking: NetworkingProtocol,
    coreDataStack: CoreDataStack
  ) {
    self.networking = networking
    self.coreDataStack = coreDataStack
  }
  
  lazy var pokemonService: PokemonServiceType = PokemonService(
    provider: self,
    networking: self.networking
  )
}
