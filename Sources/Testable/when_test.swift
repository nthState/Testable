//
//  File.swift
//  
//
//  Created by Chris Davis on 10/03/2022.
//

import Foundation
import XCTest

class BaseEvents: NSObject {

  let mapping: [String: Selector] = [
    #"(?xi)(?-x:When I.*)(?<action> tap | press)(?<identifier>.*)"#: #selector(test)

  ]

}

extension BaseEvents {

  @objc public func test(action: String, identifier: String) {
    print("Action method")
  }

}
