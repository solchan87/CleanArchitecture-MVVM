//
//  EncyclopediaViewController.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/25.
//

import UIKit

import RxSwift
import RxCocoa

final class EncyclopediaViewController: BaseViewController, BindableType {
  
  // MARK: UI
  
  // MARK: Properties
  var viewModel: EncyclopediaViewModel
  
  // MARK: Initializing
  init(viewModel: EncyclopediaViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setupView() {
    
  }
  
  func bind() {
    
  }
}
