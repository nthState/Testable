//
//  File.swift
//  
//
//  Created by Chris Davis on 04/04/2022.
//

import Foundation

/// We're using `perform` which can take 0 to 2 parameters, which means
/// any regex that is using this code really can only use 2 max inputs
class Executor {
  
  let system: BaseEvents
  
  init(system: BaseEvents) {
    self.system = system
  }
  
  @discardableResult
  func execute(step: UITestStep) -> Bool {
    
    let operation = step.operation
    let parameters = step.parameters

    switch operation {
    case .noValue(let operation):
      operation()
    case .oneValue(let operation):
      operation(parameters[0])
    case .twoValues(let operation):
      operation(parameters[0], parameters[1])
    case .selector(let selector):
      switch parameters.count {
      case 0:
         system.perform(selector)
      case 1:
         system.perform(selector, with: parameters[0])
      case 2:
         system.perform(selector, with: parameters[0], with: parameters[1])
      default:
        return false
      }
    }

    return true
  }
  
}
