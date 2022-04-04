import XCTest
@testable import Testable

final class LocationTests: XCTestCase {

  func testFeatureFilesCanBeFound() throws {

    let runner = FileManager.default
    let features = runner.findAllFeatureFiles(bundle: Bundle.module)

    XCTAssertNotEqual(0, features.count)

  }
}
