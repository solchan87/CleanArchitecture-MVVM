//
//  BaseView.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/22.
//

import UIKit

import RxSwift

class BaseView: UIView {

  var disposeBag = DisposeBag()
  
  private(set) var didSetupConstraints = false
  
  lazy private(set) var className: String = {
      return type(of: self)
        .description()
        .components(
          separatedBy: "."
        ).last ?? ""
  }()
  
  // MARK: Initializing
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.initialize()
    self.updateConstraintsIfNeeded()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
      if !self.didSetupConstraints {
          self.setupConstraints()
          self.didSetupConstraints = true
      }
      super.updateConstraints()
  }
  
  func initialize() {
      // Override point
  }

  func setupConstraints() {
      // Override point
  }

}
