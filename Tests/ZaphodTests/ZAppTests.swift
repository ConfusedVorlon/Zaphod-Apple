import XCTest
@testable import Zaphod

final class ZAppTests: XCTestCase {
    func testDecoding() {
        let appString = """
{"app":{"name":"Demo App","identifier":"com-hobbyistsoftware-example-ios-mac","slug":"demo-app","latest_news":"2021-11-05T19:00:00Z","news_url":"http://127.0.0.1:3000/a/demo-app/faqs/com-hobbyistsoftware-example-ios-mac","faq_url":"http://127.0.0.1:3000/a/demo-app/news_items"}}
"""
        let appData = appString.data(using: .utf8)!
        
        guard let info = APIClient<ZAppInfo>().decodeResponse(from: appData) else {
            XCTAssert(false,"decode failed")
            return
        }
        
        XCTAssertEqual(info.app.name, "Demo App")
    }
}
