//
//  RunnerTests.swift
//  
//
//  Created by Chris Davis on 04/04/2022.
//

import XCTest
import Combine
@testable import Testable

class RunnerTests: XCTestCase {
  
  func test_single_file() async throws {
    
    let url = FileManager.default.findFiles(named: "When.feature", bundle: Bundle.module).first!

let runner = TestRunner()


//    let system = BaseEvents()
//    let executor = Executor(system: system)
//    
//    for try await step in UITestStepSequence(featureFile: url, mappings: system.globalMap) {
//      XCTAssertTrue(executor.execute(step: step))
//    }
    
  }
  
//  func test_multiple_files() async throws {
//
//    let urls = FileManager.default.findFiles(named: nil, bundle: Bundle.module)
//
//    let system = BaseEvents()
//    let executor = Executor(system: system)
//
//    let expectation = XCTestExpectation(description: "")
//    expectation.expectedFulfillmentCount = 4
//
//    for url in urls {
//
//      let publisher = UIActionSequencePublisher(featureFile: url, mappings: system.globalMap)
//
//      for try await step in publisher.values {
//        executor.execute(step: step)
//
//        expectation.fulfill()
//      }
//
//    }
//
//    wait(for: [expectation], timeout: 10.0)
//  }
  
//  func test_commented_out_file_doesnt_execute() async throws {
//
//    let url = FileManager.default.findFiles(named: "CommentedOut.feature", bundle: Bundle.module).first!
//
//    let system = BaseEvents()
//
//    for try await _ in UITestStepSequence(featureFile: url, mappings: system.globalMap) {
//      XCTFail("There should be no steps")
//    }
//
//  }
  
  // Is this pointless?
//  func test_two_scenarios() async throws {
//    
//    let url = FileManager.default.findFiles(named: "TwoScenario.feature", bundle: Bundle.module).first!
//    
//    let system = BaseEvents()
//    
//    let expectation = XCTestExpectation(description: "scenario called twice")
//    expectation.expectedFulfillmentCount = 2
//    
//    for try await step in UITestStepSequence(featureFile: url, mappings: system.globalMap) {
//      
//      if step.action.hasPrefix("Scenario:") {
//        expectation.fulfill()
//      }
//    }
//    
//    wait(for: [expectation], timeout: 10.0)
//  }
  
}
