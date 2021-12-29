//
//  BaseNavigationViewController.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/29.
//

import UIKit

import RxSwift

class BaseNavigationController:
  UINavigationController
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
  override func loadView() {
    self.view = .init()
    self.setupView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Internal methods
  func setupView() {}
}
