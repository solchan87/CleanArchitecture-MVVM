//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Tom on 2021/12/20.
//

import XCTest
import RxBlocking

@testable import CleanMVVM

final class NetworkingStubTests: XCTestCase {
  
  private var networking: NetworkingStub!
  
  override func setUp() {
    super.setUp()
    self.networking = .init(
      testType: .stub(statusCode: 200),
      plugins: []
    )
  }
  
  override func tearDown() {
    super.tearDown()
    self.networking = nil
  }
  
  func testSuccessfulNetworkingWithStub() {
    do {
      let managers = try networking.request(
        .target(PokemonAPI.pokemons(offset: 0, limit: 20))
      )
      .toBlocking()
      .first()
      XCTAssertTrue(managers?.data.count ?? 0 > 0)
    } catch {
      XCTFail()
    }
  }
}

class FailedNetworkingStubTests: XCTestCase {
  
  private var networking: NetworkingStub!
  
  override func setUp() {
    self.networking = .init(
      testType: .stub(statusCode: 404),
      plugins: []
    )
  }
  
  override func tearDown() {
    self.networking = nil
  }
  
  func testFailedNetworkingWithStub() {
    XCTAssertThrowsError(
      try networking.request(
        .target(PokemonAPI.pokemons(offset: 0, limit: 20))
      )
      .toBlocking()
      .first()
    )
  }
}
