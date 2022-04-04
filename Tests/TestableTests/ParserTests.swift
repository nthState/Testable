import XCTest
@testable import Testable

final class ParserTests: XCTestCase {

  

  func testExample2() throws {

    //let app = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
    let app = BaseEvents()

    let mapper = Mapper()
    mapper.map(step: "When I tap login", app: app)

    XCTFail("Testing")

  }
}
