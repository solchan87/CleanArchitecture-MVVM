//
//  TransitionType.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/21.
//

import UIKit

enum TransitionType {
  case push
  case present(style: UIModalPresentationStyle? = nil)
}

enum TransitionError: Error {
    case missingNavigationController
    case cannotPop
    case unknown
}
