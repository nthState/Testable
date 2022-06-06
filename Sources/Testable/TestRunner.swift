//
//  File.swift
//  
//
//  Created by Chris Davis on 06/06/2022.
//

import Foundation
import XCTest

public class TestRunner {

  let bundle: Bundle
  let application: XCUIApplication
  let system: BaseEvents
  let executor: Executor

  public init(with bundle: Bundle, app: XCUIApplication = XCUIApplication()) {
    self.bundle = bundle
    self.application = app

    system = BaseEvents(app: self.application)
    executor = Executor(system: system)
  }

  public func execute(named: String) async throws {

    guard let url = FileManager.default.findFiles(named: named, bundle: bundle).first else {
      fatalError("No file found named: \(named)")
    }

    try await execute(url: url)
  }

  public func execute(url: URL) async throws {

    for try await step in UITestStepSequence(featureFile: url, mappings: system.globalMap) {
      //Task { @MainActor in //Note: AppLaunch state doesn't work correctly here
      await MainActor.run {
        executor.execute(step: step)
      }
    }

  }

  public func executeAll() async throws {

    let urls = FileManager.default.findFiles(bundle: bundle)

    for url in urls {

      logger.info("Feature File: \(url.lastPathComponent)")

      for try await step in UITestStepSequence(featureFile: url, mappings: system.globalMap) {
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

extension TestRunner {

  public func add(_ regex: String, _ selector: Selector) {
    system.add(regex: regex, selector: selector)
  }

}
