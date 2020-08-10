import XCTest
@testable import FieldValidator

final class FieldValidatorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FieldValidator().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
