//
//  PokemonServiceStub.swift
//  CleanMVVMTests
//
//  Created by Tom on 2022/01/15.
//

import Foundation

import RxSwift

@testable import CleanMVVM

final class PokemonServiceStub: PokemonServiceType {
  func getPokemonList(offset: Int, limit: Int) -> Single<PokemonList> {
    return Single.create { single -> Disposable in
      let pokemonList: PokemonList = .init(
        results: [
          .init(name: "Name1", url: ""),
          .init(name: "Name1", url: ""),
          .init(name: "Name1", url: ""),
          .init(name: "Name1", url: "")
        ],
        count: 301
      )
      single(.success(pokemonList))
      return Disposables.create()
    }
    .delay(.milliseconds(500), scheduler: MainScheduler.instance)
  }
}
