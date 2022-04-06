//
//  File.swift
//  
//
//  Created by Chris Davis on 04/04/2022.
//

import Foundation

func extractTestingSteps(from steps: String) -> [String] {
  //if let range = from.range(of: "Given") {
  // let steps = from[from.lowerBound...]
  let parts = steps.components(separatedBy: CharacterSet(charactersIn: "\n"))
  let trimmed = parts.compactMap({ $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) })
  let cutLast = trimmed.compactMap({ $0.last == "." ? String($0.dropLast()) : $0 })
  let included = cutLast.compactMap({ $0.starts(with: "#") ? nil : $0 })
  return included.filter({ !$0.isEmpty })
  //}
  //return []
}

func findMapping(line action: String) -> (regex: String, selector: Selector, parameters: [String])? {
  for item in globalMap {

    //logger.info("\(String(describing: item))")

    let regex = item.key
    let selector = item.value

    // What are the arguments in the string?
    let nsrange = NSRange(regex.startIndex..<regex.endIndex, in: regex)
    let namedRegex = try? NSRegularExpression(pattern: "\\(\\?\\<(\\w+)\\>", options: [])
    let nameMatches = namedRegex?.matches(in: regex, options: [], range: nsrange)
    let names = nameMatches?.map { (textCheckingResult) -> String in
      return (regex as NSString).substring(with: textCheckingResult.range(at: 1))
    }

    guard names?.isEmpty == false else {
      continue
    }

    // Extract the arguments from the step so we can pass them to the method later on
    let exp = try? NSRegularExpression(pattern: regex, options: [])
    let result = exp?.firstMatch(in: action, options: [], range: NSRange(location: 0, length: action.count))
    var parameters: [String] = []
    for name in names ?? [] {
      if let range = result?.range(withName: name), range.location != NSNotFound {
        parameters.append((action as NSString).substring(with: range))
      }
    }

    guard result != nil else {
      continue
    }

    return (regex, selector, parameters)
  }

  return nil
}
