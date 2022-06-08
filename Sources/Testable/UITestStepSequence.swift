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
  let operation: UIOperation
  let parameters: [String]
}

extension UITestStep: CustomDebugStringConvertible {
  
  public var debugDescription: String {
    "\(action) \(parameters.count)"
  }
  
}

struct UITestStepSequence: AsyncSequence {
  
  typealias Element = UITestStep
  
  var feature: String
  var mappings: [String: UIOperation]
  
  func makeAsyncIterator() -> FeatureIterator {
    FeatureIterator(feature: feature, mappings: mappings)
  }
}

struct FeatureIterator: AsyncIteratorProtocol {
  
  var lines: [String] = []
  var lineNumber: Int = 0
  var mappings: [String: UIOperation] = [: ]
  
  init(feature: String, mappings: [String: UIOperation]) {
    self.lines = extractTestingSteps(from: feature)
    self.mappings = mappings
  }
  
  mutating func next() async throws -> UITestStep? {
    
    guard lineNumber < lines.count else {
      return nil
    }
    
    let line = lines[lineNumber]
    lineNumber += 1
    
    // Find the operation in the mappings
    guard let (regex, operation, parameters) = extractMapping(line: line, mappings: mappings) else {
      return try await next()
    }
    
    let step = UITestStep(regex: regex, action: line, operation: operation, parameters: parameters)
    
    return step
  }
}
