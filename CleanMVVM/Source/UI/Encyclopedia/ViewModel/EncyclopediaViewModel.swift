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
    let getPokemonList: PublishSubject<Void>
    let loadMore: PublishSubject<Void>
  }
  
  struct Output {
    let pokemonList: BehaviorRelay<[ListedPokemon]>
  }
  
  private let disposeBag: DisposeBag = .init()
  
  private let dependency: Dependency
  private let provider: ServicesProviderType
  private let coordinator: CoordinatorType
  
  private let limit: Int = 20
  private var isLoading: Bool = false
  
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
    
    let pokemonList: BehaviorRelay<[ListedPokemon]> = .init(value: [])
    
    input.getPokemonList
      .flatMap { [weak self] _ -> Observable<[ListedPokemon]> in
        guard let self = self else { return .empty() }
        return self.provider.pokemonService
          .getPokemonList(
            offset: 0,
            limit: self.limit
          )
          .asObservable()
          .map { $0.results }
      }
      .asDriver(onErrorDriveWith: .empty())
      .drive(pokemonList)
      .disposed(by: self.disposeBag)
    
    input.loadMore
      .flatMap { [weak self] _ -> Observable<[ListedPokemon]> in
        guard let self = self else { return .empty() }
        return self.provider.pokemonService
          .getPokemonList(
            offset: pokemonList.value.count,
            limit: self.limit
          )
          .asObservable()
          .map { pokemonList.value + $0.results }
      }
      .asDriver(onErrorDriveWith: .empty())
      .drive(pokemonList)
      .disposed(by: self.disposeBag)
    
    return Output(pokemonList: pokemonList)
  }
}
