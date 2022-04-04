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

  func execute(step: UIStep) {

    let selector = step.selector
    let parameters = step.parameters

    switch parameters.count {
    case 0:
      system.perform(selector)
    case 1:
      system.perform(selector, with: parameters[0])
    case 2:
      system.perform(selector, with: parameters[0], with: parameters[1])
    default:
        break
    }

  }

}
