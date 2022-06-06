//
//  File.swift
//  
//
//  Created by Chris Davis on 04/04/2022.
//

import Foundation

class Executor {

  let system: BaseEvents

  init(system: BaseEvents) {
    self.system = system
  }

  @discardableResult
  func execute(step: UITestStep) -> Bool {

    let selector = step.selector
    let parameters = step.parameters

    switch parameters.count {
    case 0:
      return system.perform(selector) != nil
    case 1:
      return system.perform(selector, with: parameters[0]) != nil
    case 2:
      return system.perform(selector, with: parameters[0], with: parameters[1]) != nil
    default:
      return false
    }

  }

}
