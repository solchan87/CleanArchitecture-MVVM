//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Tom on 2021/12/20.
//

import XCTest
import RxBlocking

@testable import CleanMVVM

class NetworkingTests: XCTestCase {
  func testMockTest() {
    let networking: MockNetworking = .init()
    
    do {
      let pokemons = try networking.request(
        .target(PokemonAPI.pokemons(offset: 0, limit: 20))
      )
      .toBlocking()
      .first()
      let string = String(decoding: pokemons?.data ?? Data(), as: UTF8.self)
      print("🧚🏻", string)
      XCTAssertEqual(pokemons?.statusCode, 200)
    } catch {
      XCTFail()
    }
  }
}
