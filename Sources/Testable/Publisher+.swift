//
//  File.swift
//  
//
//  Created by Chris Davis on 04/04/2022.
//

import Foundation
import Combine


public func UIActionSequencePublisher(featureFile file: URL, mappings: [String: UIOperation]) -> AnyPublisher<UITestStep, Never> {
  
  let str = FileManager.default.loadFeatureFile(at: file)
  let lines = extractTestingSteps(from: str)
  
  return lines
    .publisher
    .map { line -> UITestStep in
      
      // Find the operation in the mappings
      guard let (regex, operation, parameters) = extractMapping(line: line, mappings: mappings) else {
        fatalError()
      }
      
      let step = UITestStep(regex: regex, action: line, operation: operation, parameters: parameters)
      
      return step
    }
  //.receive(on: RunLoop.main) // Note: Doesn't help
    .eraseToAnyPublisher()
}


