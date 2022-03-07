import XCTest
@testable import Testable

final class TestableTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Testable().text, "Hello, World!")
    }
}
