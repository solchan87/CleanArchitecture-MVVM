//
//  File.swift
//  CleanMVVMTests
//
//  Created by Tom on 2021/12/27.
//

import Foundation

public func getJSONData(fileName: String) -> Data {
  let url = Bundle.main.url(forResource: fileName, withExtension: "json")!
  let data = try! Data(contentsOf: url)
  return data
}
