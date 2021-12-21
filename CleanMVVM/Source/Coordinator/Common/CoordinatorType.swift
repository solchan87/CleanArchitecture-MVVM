//
//  CoordinatorType.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/21.
//

import UIKit

import RxSwift

protocol CoordinatorType {
  @discardableResult
  func transition(to scene: Scene, using style: TransitionType, animated: Bool) -> Completable
  
  @discardableResult
  func close(animated: Bool) -> Completable
}

extension CoordinatorType {
  @discardableResult
  func transition(to scene: Scene, using style: TransitionType, animated: Bool = true) -> Completable {
    return self.transition(to: scene, using: style, animated: animated)
  }
}
