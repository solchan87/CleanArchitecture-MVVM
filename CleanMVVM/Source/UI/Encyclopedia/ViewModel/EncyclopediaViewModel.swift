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
    
  }
  
  struct Output {
    
  }
  
  private let disposeBag: DisposeBag = .init()
  
  private let dependency: Dependency
  private let provider: ServicesProviderType
  private let coordinator: CoordinatorType
  
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
    
    return Output()
  }
}
