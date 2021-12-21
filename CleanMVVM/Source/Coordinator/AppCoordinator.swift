//
//  AppCoordinator.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/21.
//

import UIKit

import RxSwift
import RxCocoa

final class AppCoordinator: CoordinatorType {
  
  private var disposeBag: DisposeBag = .init()
  
  private var window: UIWindow
  private var currentViewController: UIViewController? {
    didSet {
      self.currentViewController?.rx.viewWillDisappear.asDriver()
        .drive(onNext: { [weak self] _ in
          if
            let presentingViewController = self?.currentViewController?.presentingViewController
          {
            self?.currentViewController = presentingViewController
          }
        })
        .disposed(by: self.disposeBag)
    }
  }
  
  required init(window: UIWindow) {
    self.window = window
  }
  
  func startRootViewController(_ scene: Scene) {
    let viewController = scene.viewController()
    self.window.rootViewController = viewController
    self.currentViewController = viewController
    
    self.window.makeKeyAndVisible()
  }
  
  @discardableResult
  func transition(to scene: Scene, using style: TransitionType, animated: Bool) -> Completable {
    return Completable.create { [unowned self] completable in
      let viewController = scene.viewController()
      switch style {
      case .push:
        guard
          let navigationController =
            self.currentViewController?.navigationController
        else {
          completable(.error(TransitionError.missingNavigationController))
          return Disposables.create()
        }
        
        navigationController.pushViewController(viewController, animated: animated)
        self.currentViewController = viewController
        
        completable(.completed)
        return Disposables.create()
      case let .present(style):
        if let style = style {
          viewController.modalPresentationStyle = style
        }
        self.currentViewController?.present(viewController, animated: animated, completion: nil)
        self.currentViewController = viewController
        
        completable(.completed)
        return Disposables.create()
      }
    }
  }
  
  @discardableResult
  func close(animated: Bool) -> Completable {
    return Completable.create { [unowned self] completable in
      if
        let presentingViewController = self.currentViewController?.presentingViewController
      {
        self.currentViewController?.dismiss(animated: animated) {
          self.currentViewController = presentingViewController
          completable(.completed)
        }
        return Disposables.create()
      } else if let navigationController = self.currentViewController?.navigationController {
        guard navigationController.popViewController(animated: animated) != nil else {
          completable(.error(TransitionError.cannotPop))
          return Disposables.create()
        }
        self.currentViewController = navigationController.viewControllers.last!
        completable(.completed)
      } else {
        completable(.error(TransitionError.unknown))
      }
      return Disposables.create()
    }
  }
}
