//
//  Networking.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/21.
//

import Foundation

import Moya
import RxSwift

protocol NetworkingProtocol {
  func request(_ target: MultiTarget,
               file: StaticString,
               function: StaticString,
               line: UInt)
  -> Single<Response>
  
  func requestWithProgress(
    _ target: MultiTarget,
    file: StaticString,
    function: StaticString,
    line: UInt
  ) -> Observable<ProgressResponse>
}

extension NetworkingProtocol {
  func request(_ target: MultiTarget,
               file: StaticString = #file,
               function: StaticString = #function,
               line: UInt = #line)
  -> Single<Response> {
    return self.request(target,
                        file: file,
                        function: function,
                        line: line)
  }
  
  func requestWithProgress(
    _ target: MultiTarget,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) -> Observable<ProgressResponse> {
    return self.requestWithProgress(
      target,
      file: file,
      function: function,
      line: line
    )
  }
}

final class Networking: MoyaProvider<MultiTarget>,
                        NetworkingProtocol {
  init(plugins: [PluginType] = []) {
    let session = MoyaProvider<MultiTarget>.defaultAlamofireSession()
    session.sessionConfiguration.timeoutIntervalForRequest = 10
    
    super.init(session: session, plugins: plugins)
  }
  
  func request(
    _ target: MultiTarget,
    file: StaticString,
    function: StaticString,
    line: UInt
  ) -> Single<Response> {
    let requestString = "\(target.method.rawValue) \(target.path)"
    return self.rx.request(target)
      .filterSuccessfulStatusCodes()
      .do(
        onSuccess: { value in
          let message = "SUCCESS: \(requestString) (\(value.statusCode))"
          log.debug(message)
        },
        onError: { error in
          if let response = (error as? MoyaError)?.response {
            if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
              let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
              log.error(message)
            } else if let rawString = String(data: response.data, encoding: .utf8) {
              let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
              log.error(message)
            } else {
              let message = "FAILURE: \(requestString) (\(response.statusCode))"
              log.error(message)
            }
          } else {
            let message = "FAILURE: \(requestString)\n\(error)"
            log.error(message)
          }
        },
        onSubscribed: {
          let message = "REQUEST: \(requestString)"
          log.info(message)
        }
      )
  }
  
  func requestWithProgress(
    _ target: MultiTarget,
    file: StaticString,
    function: StaticString,
    line: UInt
  ) -> Observable<ProgressResponse> {
    let requestString = "\(target.method.rawValue) \(target.path)"
    return self.rx.requestWithProgress(target)
  }
}
