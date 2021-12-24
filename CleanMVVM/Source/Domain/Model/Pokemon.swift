//
//  Pokemon.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/24.
//

import Foundation

struct Welcome: Decodable {
  let results: [Pokemon]
  let count: Int
}

// MARK: - Result
struct Pokemon: Decodable {
  let name: String
  let url: String
}
