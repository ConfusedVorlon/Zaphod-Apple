import XCTest
@testable import Zaphod

final class ZAppTests: XCTestCase {
    func testDecoding() {

        // swiftlint:disable line_length
        let objectString = """
{"app":{"name":"Demo App","identifier":"com-hobbyistsoftware-example","slug":"demo-app","latest_news":"2021-11-05T19:00:00Z","faq_count":1,"faq_url":"http://127.0.0.1:3000/a/demo-app/faqs/com-hobbyistsoftware-example","news_url":"http://127.0.0.1:3000/a/demo-app/news_items"}}
"""
        // swiftlint:enable line_length

        let data = objectString.data(using: .utf8)!

        guard let info: ZAppInfo = data.decode() else {
            XCTAssert(false, "decode failed")
            return
        }

        XCTAssertEqual(info.app.name, "Demo App")
    }
}
