import XCTest
@testable import DuctTape

final class DuctTapeTests: XCTestCase {

    static var allTests = [
        ("testDuctTape_dynamicMemberLookup", testDuctTape_dynamicMemberLookup),
        ("testDuctTape_reinforce", testDuctTape_reinforce)
    ]

    func testDuctTape_dynamicMemberLookup() {
        let intValue = Int(arc4random())
        let stringValue = String(arc4random())
        let boolValue = arc4random() % 2 == 0

        let object = Object()
            .ductTape
            .intValue(intValue)
            .stringValue(stringValue)
            .boolValue(boolValue)
            .build()

        XCTAssertEqual(object.intValue, intValue)
        XCTAssertEqual(object.stringValue, stringValue)
        XCTAssertEqual(object.boolValue, boolValue)
    }

    func testDuctTape_reinforce() {
        let intValue = Int(arc4random())
        let stringValue = String(arc4random())
        let boolValue = arc4random() % 2 == 0

        let object = Object()
            .ductTape
            .reinforce {
                $0.intValue = intValue
                $0.stringValue = stringValue
                $0.boolValue = boolValue
            }
            .build()

        XCTAssertEqual(object.intValue, intValue)
        XCTAssertEqual(object.stringValue, stringValue)
        XCTAssertEqual(object.boolValue, boolValue)
    }

    func testDuctTape_without_protocol() {
        let intValue = Int(arc4random())
        let stringValue = String(arc4random())
        let boolValue = arc4random() % 2 == 0

        let object = Builder(ObjectBase())
            .reinforce {
                $0.intValue = intValue
                $0.stringValue = stringValue
                $0.boolValue = boolValue
            }
            .build()

        XCTAssertEqual(object.intValue, intValue)
        XCTAssertEqual(object.stringValue, stringValue)
        XCTAssertEqual(object.boolValue, boolValue)
    }

    private class ObjectBase {
        var intValue: Int?
        var stringValue: String?
        var boolValue: Bool?
    }

    private final class Object: ObjectBase, DuctTapeCompatible {}
}
