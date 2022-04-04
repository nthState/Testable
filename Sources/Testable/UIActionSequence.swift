//
//  File.swift
//  
//
//  Created by Chris Davis on 10/03/2022.
//

import Foundation

struct UIStep {
  let regex: String
  let action: String
  let selector: Selector
  let parameters: [String]
}

extension UIStep: CustomDebugStringConvertible {

  var debugDescription: String {
    "\(action) \(parameters.count)"
  }

}

struct UIActionSequence: AsyncSequence {

  typealias Element = UIStep

  var featureFile: URL

  func makeAsyncIterator() -> FeatureFileIterator {
    FeatureFileIterator(file: featureFile)
  }
}

struct FeatureFileIterator: AsyncIteratorProtocol {

  var lines: [String] = []
  var lineNumber: Int = 0

  init(file: URL) {
    let str = FileManager.default.loadFeatureFile(at: file)
    self.lines = extractTestingSteps(from: str)
  }

  mutating func next() async throws -> UIStep? {

    guard lineNumber < lines.count else {
      return nil
    }

    let line = lines[lineNumber]
    lineNumber += 1

    // Find the selector in the mappings
    guard let (regex, selector, parameters) = findMapping(line: line) else {
      return try await next()
    }

    let step = UIStep(regex: regex, action: line, selector: selector, parameters: parameters)

    return step
  }
}

extension FeatureFileIterator {

  func findMapping(line action: String) -> (regex: String, selector: Selector, parameters: [String])? {
    for item in globalMap {

      print(item)

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

      return (regex, selector, parameters)
    }

    return nil
  }

}

extension FeatureFileIterator {

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

}

