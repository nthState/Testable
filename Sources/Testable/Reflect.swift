////
////  File.swift
////  
////
////  Created by Chris Davis on 10/03/2022.
////
//
//import Foundation
//import XCTest
//
//class Reflect {}
//
//extension Reflect {
//
//  func reflect(step: String, app: BaseEvents) {
//
//    print("Executing Step: \(step)")
//
//    let mirror = Mirror(reflecting: app)
//    for child in mirror.children {
//
//      print(child)
//
//      if let r = child.value as? TestableExpression<Dictionary<AnyHashable, Any>> {
//
//        // Get names from regex
//        let nsrange = NSRange(r.expression.startIndex..<r.expression.endIndex, in: r.expression)
//        let namedRegex = try? NSRegularExpression(pattern: "\\(\\?\\<(\\w+)\\>", options: [])
//        let nameMatches = namedRegex?.matches(in: r.expression, options: [], range: nsrange)
//        let names = nameMatches?.map { (textCheckingResult) -> String in
//          return (r.expression as NSString).substring(with: textCheckingResult.range(at: 1))
//        }
//
//        print(names)
//
//        // Parse regex into dictionary...why?
//        let regex = try? NSRegularExpression(pattern: r.expression, options: [])
//        let result = regex?.firstMatch(in: step, options: [], range: NSRange(location: 0, length: step.count))
//        var dict = [String: String]()
//        for name in names ?? [] {
//          if let range = result?.range(withName: name), range.location != NSNotFound {
//            dict[name] = (step as NSString).substring(with: range)
//          }
//        }
//
//        print(dict)
//
//
//        // We only want to call the method if it matches the expression fully
//        let fullrange = NSRange(step.startIndex..<step.endIndex, in: step)
//        let fullregex = try? NSRegularExpression(pattern: r.expression, options: [])
//        if let _ = fullregex?.firstMatch(in: step, options: [], range: fullrange) {
//
//          let propertyName = String(child.label?.dropFirst(1) ?? "")
//          app.setValue(dict, forKey: propertyName)
//
//          print("--Executed")
//        }
//
//      }
//
//    }
//
//  }
//
//}
