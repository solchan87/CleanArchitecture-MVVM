//
//  Scene.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/21.
//

import UIKit

enum Scene {
  case encyclopedia(viewModel: EncyclopediaViewModel)
}

extension Scene {
  func viewController() -> UIViewController {
    switch self {
    case let .encyclopedia(viewModel):
      let viewController: EncyclopediaViewController = .init(
        viewModel: viewModel
      )
      return viewController
    }
  }
}
