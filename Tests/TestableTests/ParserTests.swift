import XCTest
@testable import Testable

final class ParserTests: XCTestCase {
  
  func test_tap_expands_correctly() throws {
    
    //let app = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
    
    let mappings: [String: UIOperation] = [#"(?xi)(?-x:When I.*)(?<action> tap | press)(\s)(?<identifier>.*)"#: UIOperation.selector(Selector(String()))]
    
    let result = extractMapping(line: "When I tap login", mappings: mappings)
    
    XCTAssertEqual(result?.parameters.first, "tap", "Should match")
    XCTAssertEqual(result?.parameters.last, "login", "Should match")
    
  }
  
  func test_swipe_expands_correctly() throws {
    
    let mappings: [String: UIOperation] = [#"(?xi)(?-x:And I swipe.*)(?<direction> left | right)(?-x: on )(?<identifier>.*)"#: UIOperation.selector(Selector(String()))]
    
    let result = extractMapping(line: "And I swipe left on myButton", mappings: mappings)
    
    XCTAssertEqual(result?.parameters.first, "left", "Should match")
    XCTAssertEqual(result?.parameters.last, "myButton", "Should match")
    
  }
}
