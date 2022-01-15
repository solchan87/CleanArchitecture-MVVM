//
//  NetworkingStub.swift
//  CleanMVVMTests
//
//  Created by Tom on 2022/01/15.
//

import Foundation

import RxSwift
import Moya

@testable import CleanMVVM

final class NetworkingStub: MoyaProvider<MultiTarget>,
                            NetworkingProtocol {
  
  enum TestType {
    case stub(statusCode: Int)
    case online
  }
  
  init(
    testType: TestType,
    plugins: [PluginType]
  ) {
    switch testType {
    case let .stub(statusCode):
      super.init(
        endpointClosure: { target in
          return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: {
              .networkResponse(statusCode , target.sampleData)
            },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers)
        },
        stubClosure: MoyaProvider.delayedStub(1),
        plugins: plugins
      )
    case .online:
      let session = MoyaProvider<MultiTarget>.defaultAlamofireSession()
      session.sessionConfiguration.timeoutIntervalForRequest = 10
      
      super.init(session: session, plugins: plugins)
    }
    
  }
  
  func request(_ target: MultiTarget,
               file: StaticString,
               function: StaticString,
               line: UInt)
  -> Single<Response> {
    return self.rx.request(target)
      .filterSuccessfulStatusCodes()
  }
}
