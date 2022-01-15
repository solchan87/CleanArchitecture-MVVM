//
//  ServicesProviderStub.swift
//  CleanMVVMTests
//
//  Created by Tom on 2022/01/15.
//

import Foundation

@testable import CleanMVVM

final class ServicesProviderStub: ServicesProviderType {
  var pokemonService: PokemonServiceType = PokemonServiceStub()
}
