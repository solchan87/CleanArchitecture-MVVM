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
  func testSuccessfulNetworking() {
    let networking: MockNetworking = .init(
      testType: .stub(
        statusCode: 200,
        mockedData: getJSONData(fileName: "PokemonListJSON")
      ),
      plugins: []
    )
    
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
  
  func testFailedNetworking() {
    let networking: MockNetworking = .init(
      testType: .stub(
        statusCode: 404,
        mockedData: getJSONData(fileName: "PokemonListJSON")
      ),
      plugins: []
    )
    
    do {
      let pokemons = try networking.request(
        .target(PokemonAPI.pokemons(offset: 0, limit: 20))
      )
      .toBlocking()
      .first()
      let string = String(decoding: pokemons?.data ?? Data(), as: UTF8.self)
      print("🧚🏻", string)
      XCTAssertEqual(pokemons?.statusCode, 404)
    } catch {
      XCTFail()
    }
  }
}
