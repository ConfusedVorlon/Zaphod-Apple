import XCTest
@testable import Zaphod

final class ZSubscribeTests: XCTestCase {
    func testDecoding() {
        let objectString = """
{"app_user":{"id":"96381b13-0345-4fe0-8b09-7ad8cb8090eb"}}
"""
        let data = objectString.data(using: .utf8)!
        
        guard let wrapper:ZSignupWrapper = data.decode() else {
            XCTAssert(false,"decode failed")
            return
        }
        
        XCTAssertEqual(wrapper.user.serverId?.uuidString.lowercased(), "96381b13-0345-4fe0-8b09-7ad8cb8090eb")
        
        let serverId = wrapper.user.serverId
        XCTAssertNotNil(serverId)
        
        XCTAssertEqual(makeString(uuid:serverId!) , "string: 96381b13-0345-4fe0-8b09-7ad8cb8090eb".uppercased())
    }
    
    func makeString(uuid:UUID) -> String {
        return "string: \(uuid)".uppercased()
    }
}
