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
  
  func testSingleFile() async throws {
    
    let url = FileManager.default.findAllFeatureFiles(named: "When.feature", bundle: Bundle.module).first!
    
    let system = BaseEvents()
    let executor = Executor(system: system)
    
    for try await step in UITestStepSequence(featureFile: url) {
      executor.execute(step: step)
    }
    
  }
  
  func testMultipleFiles() async throws {
    
    let urls = FileManager.default.findAllFeatureFiles(named: nil, bundle: Bundle.module)
    
    for url in urls {
      
      let system = BaseEvents()
      let executor = Executor(system: system)

      let publisher = UIActionSequencePublisher(featureFile: url)
      
      for try await step in publisher.values {
        executor.execute(step: step)
      }
      
    }
    
  }
  
}
