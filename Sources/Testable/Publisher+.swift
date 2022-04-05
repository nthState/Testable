//
//  File.swift
//  
//
//  Created by Chris Davis on 04/04/2022.
//

import Foundation
import Combine


public func UIActionSequencePublisher(featureFile file: URL) -> AnyPublisher<UITestStep, Never> {
  
  let str = FileManager.default.loadFeatureFile(at: file)
  let lines = extractTestingSteps(from: str)
  
  return lines
    .publisher
    .map { line -> UITestStep in
      
      // Find the selector in the mappings
      guard let (regex, selector, parameters) = findMapping(line: line) else {
        fatalError()
      }
      
      let step = UITestStep(regex: regex, action: line, selector: selector, parameters: parameters)
      
      return step
    }
    .eraseToAnyPublisher()
}

