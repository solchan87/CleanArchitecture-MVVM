//
//  BaseCollectionView.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/22.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell, ReusableView {
  
  var disposeBag = DisposeBag()
  
  private(set) var didSetupConstraints = false
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initialize()
    self.updateConstraintsIfNeeded()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: .zero)
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.disposeBag = DisposeBag()
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
