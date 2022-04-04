//
//  File.swift
//
//
//  Created by Chris Davis on 04/04/2022.
//

import Foundation
import XCTest

class Mapper {}

/**

 Limitations:
 Without NSInvocation we are limited to 2 inputs via performSelector
 */
extension Mapper {

    /**
     Return action history
     */

    func map(step: String, app: BaseEvents) {

        print("Executing Step: \(step)")


        for item in app.mapping {

            print(item)

            let expression = item.key
            let selector = item.value

            // What are the arguments in the string?
            let nsrange = NSRange(expression.startIndex..<expression.endIndex, in: expression)
            let namedRegex = try? NSRegularExpression(pattern: "\\(\\?\\<(\\w+)\\>", options: [])
            let nameMatches = namedRegex?.matches(in: expression, options: [], range: nsrange)
            let names = nameMatches?.map { (textCheckingResult) -> String in
                return (expression as NSString).substring(with: textCheckingResult.range(at: 1))
            }

            print(names)

            // Extract the arguments from the step so we can pass them to the method later on
            let regex = try? NSRegularExpression(pattern: expression, options: [])
            let result = regex?.firstMatch(in: step, options: [], range: NSRange(location: 0, length: step.count))
            var parameters: [String] = []
            for name in names ?? [] {
                if let range = result?.range(withName: name), range.location != NSNotFound {
                    parameters.append((step as NSString).substring(with: range))
                }
            }

            switch parameters.count {
            case 0:
                app.perform(selector)
            case 1:
                app.perform(selector, with: parameters[0])
            case 2:
                app.perform(selector, with: parameters[0], with: parameters[1])
            default:
                break
            }

        }

    }

}

