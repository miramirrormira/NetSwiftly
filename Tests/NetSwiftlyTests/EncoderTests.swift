@testable import NetSwiftly
import XCTest

final class EncoderTests: XCTestCase {

    func test_JSONBodyEncoder() {
        
        let parameters: [String: Any] = ["name": "name", "value": 123]
        do {
            let encodedData = try JSONBodyEncoder().encode(parameters)
            let decodedObject = try JSONDecoder().decode(TestStruct.self, from: encodedData)
            XCTAssertEqual(decodedObject.value, 123)
            XCTAssertEqual(decodedObject.name, "name")
        } catch {
            XCTFail("Failed to encode data: \(error)")
        }
        
    }
    
    func test_toDictionary() throws {
        let object = TestStruct(name: "name", value: nil)
        let dictionary = try object.toDictionary()
        XCTAssertNil(dictionary["value"])
        XCTAssertEqual(dictionary["name"] as? String, "name")
    }
}
