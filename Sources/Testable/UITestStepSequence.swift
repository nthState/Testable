//
//  File.swift
//  
//
//  Created by Chris Davis on 10/03/2022.
//

import Foundation

public struct UITestStep {
  let regex: String
  let action: String
  let selector: Selector
  let parameters: [String]
}

extension UITestStep: CustomDebugStringConvertible {

  public var debugDescription: String {
    "\(action) \(parameters.count)"
  }

}

struct UITestStepSequence: AsyncSequence {

  typealias Element = UITestStep

  var featureFile: URL
    var mappings: [String: Selector] = [: ]

  func makeAsyncIterator() -> FeatureFileIterator {
      FeatureFileIterator(file: featureFile, mappings: mappings)
  }
}

struct FeatureFileIterator: AsyncIteratorProtocol {

  var lines: [String] = []
  var lineNumber: Int = 0
    var mappings: [String: Selector] = [: ]

    init(file: URL, mappings: [String: Selector]) {
    let str = FileManager.default.loadFeatureFile(at: file)
    self.lines = extractTestingSteps(from: str)
        self.mappings = mappings
  }

  mutating func next() async throws -> UITestStep? {

    guard lineNumber < lines.count else {
      return nil
    }

    let line = lines[lineNumber]
    lineNumber += 1

    // Find the selector in the mappings
      guard let (regex, selector, parameters) = extractMapping(line: line, mappings: mappings) else {
      return try await next()
    }

    let step = UITestStep(regex: regex, action: line, selector: selector, parameters: parameters)

    return step
  }
}
