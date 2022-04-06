import XCTest
@testable import Testable

final class ParserTests: XCTestCase {

  func test_tap_expands_correctly() throws {

    //let app = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")

    let result = findMapping(line: "When I tap login")

    XCTAssertEqual(result?.parameters.first, "tap", "Should match")
    XCTAssertEqual(result?.parameters.last, "login", "Should match")

  }

    func test_swipe_expands_correctly() throws {

      let result = findMapping(line: "And I swipe left on myButton")

      XCTAssertEqual(result?.parameters.first, "left", "Should match")
      XCTAssertEqual(result?.parameters.last, "myButton", "Should match")

    }
}
