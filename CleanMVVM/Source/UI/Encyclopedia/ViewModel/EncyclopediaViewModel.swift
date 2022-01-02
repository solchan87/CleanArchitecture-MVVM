//
//  EncyclopediaViewModel.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/25.
//

import Foundation

import RxSwift
import RxCocoa

final class EncyclopediaViewModel: ViewModelType {
  struct Dependency {
    
  }
  
  struct Input {
    let getPokemonList: PublishSubject<Void> = .init()
    let loadMore: PublishSubject<Void> = .init()
  }
  
  struct Output {
    let pokemonList: Driver<[ListedPokemon]>
  }
  
  private let disposeBag: DisposeBag = .init()
  
  private let dependency: Dependency
  private let provider: ServicesProviderType
  private let coordinator: CoordinatorType
  
  private let limit: Int = 20
  private var isLoading: Bool = false
  
  private var pokemons: [ListedPokemon] = .init()
  
  init(
    dependency: Dependency,
    provider: ServicesProviderType,
    coordinator: CoordinatorType
  ) {
    self.dependency = dependency
    self.provider = provider
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    
    let pokemonList = input.getPokemonList
      .flatMap { [weak self] _ -> Observable<[ListedPokemon]> in
        guard let self = self else { return .empty() }
        return self.provider.pokemonService
          .getPokemonList(
            offset: 0,
            limit: self.limit
          )
          .asObservable()
          .map { [unowned self] loadedPokemons -> [ListedPokemon] in
            self.pokemons.append(contentsOf: loadedPokemons.results)
            return self.pokemons
          }
      }
      .asDriver(onErrorDriveWith: .empty())
    
    return Output(pokemonList: pokemonList)
  }
}
