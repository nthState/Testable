import XCTest
@testable import Testable

final class LocationTests: XCTestCase {

  func test_feature_files_can_be_found() throws {

    let runner = FileManager.default
    let features = runner.findFiles(bundle: Bundle.module)

    XCTAssertNotEqual(0, features.count)

  }
}
