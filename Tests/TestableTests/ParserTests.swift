import XCTest
@testable import Testable

final class ParserTests: XCTestCase {

  func testExample2() throws {

    //let app = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")

    let iterator = FeatureFileIterator(file: URL(string: "ffff")!)
    let result = iterator.findMapping(line: "When I tap login")

    XCTAssertEqual(result?.parameters.count, 2, "Two parameters")

  }
}
