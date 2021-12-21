//
//  ViewModelType.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/21.
//

import Foundation

import RxSwift

protocol ViewModelType {
  associatedtype Dependency
  associatedtype Input
  associatedtype Output
  
  init(
    dependency: Dependency,
    provider: ServicesProviderType,
    coordinator: CoordinatorType
  )
  
  func transform(input: Input) -> Output
}
