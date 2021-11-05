import XCTest
@testable import Zaphod

final class ZaphodTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Zaphod().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
