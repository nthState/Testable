//
//  File.swift
//  
//
//  Created by Chris Davis on 06/06/2022.
//

import Foundation
import XCTest
import OSLog

public class TestRunner {

  let application: XCUIApplication
  let system: BaseEvents
  let executor: Executor

  let logger = Logger(subsystem: "com.testable", category: "TestRunner")
  
  public init(app: XCUIApplication = XCUIApplication()) {
    self.application = app
    
    system = BaseEvents(app: self.application)
    executor = Executor(system: system)
  }

  public func execute(string: String) async throws {

    for try await step in UITestStepSequence(feature: string, mappings: system.globalMap) {
      //Task { @MainActor in //Note: AppLaunch state doesn't work correctly here
      await MainActor.run {
        executor.execute(step: step)
      }
    }
  }
  
  public func execute(named: String, in bundle: Bundle) async throws {
    
    guard let url = FileManager.default.findFiles(named: named, bundle: bundle).first else {
      fatalError("No file found named: \(named)")
    }

    let str = FileManager.default.loadFeatureFile(at: url)

    try await execute(string: str)
  }
  
  public func execute(url: URL) async throws {

    let str = FileManager.default.loadFeatureFile(at: url)

    try await execute(string: str)

  }
  
  public func executeAll(in bundle: Bundle) async throws {
    
    let urls = FileManager.default.findFiles(bundle: bundle)
    
    for url in urls {
      
      logger.info("Feature File: \(url.lastPathComponent)")

      let str = FileManager.default.loadFeatureFile(at: url)
      
      for try await step in UITestStepSequence(feature: str, mappings: system.globalMap) {
        //Task { @MainActor in //Note: AppLaunch state doesn't work correctly here
        await MainActor.run {
          executor.execute(step: step)
        }
      }
      
      await MainActor.run {
        application.terminate()
      }
    }
    
    //      let publisher = UIActionSequencePublisher(featureFile: url)
    //
    //      for try await step in publisher.values {
    //        Task { @MainActor in
    //          executor.execute(step: step)
    //        }
    //      }
    
  }
  
}

public enum UIOperation {
  case noValue(() -> Void)
  case oneValue((String) -> Void)
  case twoValues((String, String) -> Void)
  case selector(Selector)
}

extension TestRunner {
  
  public func add(_ regex: String, _ selector: Selector) {
    system.add(regex: regex, operation: UIOperation.selector(selector))
  }

  public func add(_ regex: String, _ closure: @escaping () -> Void) {
    system.add(regex: regex, operation: UIOperation.noValue(closure))
  }

  public func add(_ regex: String, _ closure: @escaping (String) -> Void) {
    system.add(regex: regex, operation: UIOperation.oneValue(closure))
  }

  public func add(_ regex: String, _ closure: @escaping (String, String) -> Void) {
    system.add(regex: regex, operation: UIOperation.twoValues(closure))
  }
  
}
