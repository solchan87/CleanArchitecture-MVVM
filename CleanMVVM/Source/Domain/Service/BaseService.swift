//
//  BaseService.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/21.
//

import Foundation

class BaseService {
  unowned let provider: ServicesProviderType
  
  init(provider: ServicesProviderType) {
    self.provider = provider
  }
}
