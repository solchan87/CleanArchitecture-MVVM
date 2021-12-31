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
    let getEncyclopediaList: PublishSubject<Void> = .init()
  }
  
  struct Output {
    let encyclopediaList: BehaviorRelay<PokemonList>
  }
  
  private let disposeBag: DisposeBag = .init()
  
  private let dependency: Dependency
  private let provider: ServicesProviderType
  private let coordinator: CoordinatorType
  
  let currentOffset: Int = 0
  let limit: Int = 20
  
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
    let encyclopediaList: BehaviorRelay<PokemonList>
    
//    encyclopediaList = input.getEncyclopediaList.asObservable()
//      .flatMap { [weak self] _ -> Driver<PokemonList> in
//        guard let self = self else { return .empty() }
//        self.provider.pokemonService.getPokemonList(
//          offset: self.currentOffset,
//          limit: self.limit
//        )
//        .asDriver(onErrorDriveWith: .empty())
//      }
    
    return Output(encyclopediaList: encyclopediaList)
  }
}
