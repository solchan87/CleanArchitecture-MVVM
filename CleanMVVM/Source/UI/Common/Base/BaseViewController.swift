//
//  BaseViewController.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/22.
//

import UIKit

import RxCocoa
import RxSwift

class BaseViewController:
  UIViewController
{
  
  // MARK: - Properties
  lazy private(set) var className: String = {
    return type(of: self)
      .description()
      .components(
        separatedBy: "."
      ).last ?? ""
  }()
  
  var disposeBag: DisposeBag = DisposeBag()
  
  private(set) var didSetupConstraints: Bool = false
  
  // MARK: - Initialization & Deinitialization
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Deinit
  
  deinit {
    log.info("👹🗑 deinit -> \(self.className)")
  }
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.setNeedsUpdateConstraints()
  }
  
  // MARK: - Inheritance
  
  // MARK: - Layout Constraints
  
  override func updateViewConstraints() {
    setupConstraintsIfNeeded()
    super.updateViewConstraints()
  }
  
  // MARK: - Internal methods
  
  func setupConstraints() {
    // Override here
  }
  
  // MARK: - Private methods
  
  private func setupConstraintsIfNeeded() {
    guard !didSetupConstraints else { return }
    setupConstraints()
    didSetupConstraints = true
  }
}
