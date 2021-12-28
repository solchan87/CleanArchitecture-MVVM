////
////  MockNetworking.swift
////  CleanMVVMTests
////
////  Created by Tom on 2021/12/27.
////
//
import Foundation
import RxSwift
import Moya

@testable import CleanMVVM

final class MockNetworking: MoyaProvider<MultiTarget>,
                        NetworkingProtocol {
  
  init(statusCode: Int = 200) {
    super.init(
      stubClosure: MoyaProvider.delayedStub(1),
      plugins: []
    )
  }
  
  func request(_ target: MultiTarget,
               file: StaticString,
               function: StaticString,
               line: UInt)
  -> Single<Response> {
    return self.rx.request(target)
  }
}
