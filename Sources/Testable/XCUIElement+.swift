//
//  File.swift
//  
//
//  Created by Chris Davis on 05/04/2022.
//

import Foundation
import XCTest

extension XCUIElement {

  func isVisible(timeout: TimeInterval = 60) -> Bool {
    if exists && isHittable {
      return true
    }
    return waitFor(predicate: "exists == true && isHittable == true", timeout: timeout)
  }

  private func waitFor(predicate: String, timeout: TimeInterval = 60) -> Bool {
    let testCase = XCTestCase()
    let predicate = NSPredicate(format: predicate)
    let expectation = testCase.expectation(for: predicate, evaluatedWith: self)

    let result = XCTWaiter.wait(for: [expectation], timeout: timeout)

    //if case XCTWaiter.Result.completed = result {
    if [XCTWaiter.Result.completed, .invertedFulfillment].contains(result) {
      return true
    }

    return false
  }

}
