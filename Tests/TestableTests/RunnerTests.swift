//
//  RunnerTests.swift
//  
//
//  Created by Chris Davis on 04/04/2022.
//

import XCTest
@testable import Testable

class RunnerTests: XCTestCase {

  func testExample() async throws {

    let url = FileManager.default.findAllFeatureFiles(named: "When.feature", bundle: Bundle.module).first!

    let system = BaseEvents()
    let executor = Executor(system: system)

    for try await step in UIActionSequence(featureFile: url) {
      executor.execute(step: step)
    }

  }

}
