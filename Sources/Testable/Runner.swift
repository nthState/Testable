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

    //    // If a download fails, we simply move on to
    //    // the next URL in this case:
    //    guard let data = try? Data(contentsOf: url) else {
    //      return next()
    //    }

    let step = UIStep(regex: "", action: line)

    return step
  }
}

extension FeatureFileIterator {

  func extractTestingSteps(from: String) -> [String] {
    if let range = from.range(of: "Given") {
      let steps = from[range.lowerBound...]
      let parts = steps.components(separatedBy: CharacterSet(charactersIn: "\n"))
      let trimmed = parts.compactMap({ $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) })
      let cutLast = trimmed.compactMap({ $0.last == "." ? String($0.dropLast()) : $0 })
      let included = cutLast.compactMap({ $0.starts(with: "#") ? nil : $0 })
      return included
    }
    return []
  }

}

