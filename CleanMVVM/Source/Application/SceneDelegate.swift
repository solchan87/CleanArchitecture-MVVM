//
//  SceneDelegate.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  var coordinator: AppCoordinator?
  
  private let provider: ServicesProvider = .init(
    networking: Networking(),
    coreDataStack: CoreDataStack()
  )
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    self.window = UIWindow(windowScene: windowScene)
    self.coordinator = .init(window: self.window!)
    
    self.coordinator?.startRootViewController(
      .encyclopedia(
        viewModel: .init(
          dependency: .init(),
          provider: self.provider,
          coordinator: self.coordinator!)
      )
    )
  }
}

