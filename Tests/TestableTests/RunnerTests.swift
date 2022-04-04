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

    let url = Bundle.module.url(forResource: "Example", withExtension: "feature")!

    //let runner = FileManager.default
    //let features = runner.findAllFeatureFiles(bundle: Bundle.module)
    //runner.loadFeatureFile(at: url)

    for try await step in UIActionSequence(featureFile: url) {
      something.execute(step)
    }

  }


}
