//
//  BindableType.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/21.
//

import UIKit

protocol BindableType {
  associatedtype ViewModelType
  
  var viewModel: ViewModelType { get }
  func bind()
}
