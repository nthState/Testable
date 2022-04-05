//
//  File.swift
//  
//
//  Created by Chris Davis on 10/03/2022.
//

import Foundation
import XCTest

let globalMap: [String: Selector] = [
  #"(?xi)(?-x:When I.*)(?<action> tap | press)(?<identifier>.*)"#: #selector(BaseEvents.test)

]

class BaseEvents: NSObject {

}

extension BaseEvents {

  @objc public func test(action: String, identifier: String) {
    logger.info("Action: \(action) \(identifier)")
  }

}
