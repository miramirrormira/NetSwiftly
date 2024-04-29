@testable import NetSwiftly
import XCTest

final class URLComponentsBuilderTests: XCTestCase {
    
    func test_initilize_urlComponentsPropertyShouldNotBeNil() {
        let builder = URLComponentsBuilder()
        XCTAssertNotNil(builder.urlComponents)
    }

    func test_addHost() {
        let builder = URLComponentsBuilder()
        builder.addHost("www.example.com")
        XCTAssertEqual(builder.urlComponents.host, "www.example.com")
    }
    
    func test_addScheme() {
        let builder = URLComponentsBuilder()
        builder.addScheme("https")
        XCTAssertEqual(builder.urlComponents.scheme, "https")
    }
    
    func test_updateQueryItems_with_empty_parameters_query_items_should_not_change() {
        let builder = URLComponentsBuilder()
        builder.urlComponents.queryItems = [URLQueryItem(name: "param1", value: "1")]
        let oldQueryItems = builder.urlComponents.queryItems
        builder.updateQueryItems([:])
        XCTAssertEqual(builder.urlComponents.queryItems, oldQueryItems)
    }
    
    func test_updateQueryItems_add_to_empty_query_items_with_one_parameter() throws {
        let builder = URLComponentsBuilder()
        builder.updateQueryItems(["param1":1])
        let unwrappedQueryItems = try XCTUnwrap(builder.urlComponents.queryItems)
        XCTAssertEqual(unwrappedQueryItems.count, 1)
        XCTAssertTrue(unwrappedQueryItems.contains(URLQueryItem(name: "param1", value: "1")))
    }
    
    func test_updateQueryItems_add_to_non_empty_query_items_with_one_parameter() throws {
        let builder = URLComponentsBuilder()
        builder.urlComponents.queryItems = [URLQueryItem(name: "param1", value: "1")]
        builder.updateQueryItems(["param2" : 2])
        let unwrappedQueryItems = try XCTUnwrap(builder.urlComponents.queryItems)
        XCTAssertEqual(unwrappedQueryItems.count, 2)
        XCTAssertTrue(unwrappedQueryItems.contains(URLQueryItem(name: "param1", value: "1")))
        XCTAssertTrue(unwrappedQueryItems.contains(URLQueryItem(name: "param2", value: "2")))
    }
    
    func test_updateQueryItems_update_query_item() throws {
        let builder = URLComponentsBuilder()
        builder.urlComponents.queryItems = [URLQueryItem(name: "param1", value: "1")]
        builder.updateQueryItems(["param1" : 2])
        let unwrappedQueryItems = try XCTUnwrap(builder.urlComponents.queryItems)
        XCTAssertEqual(unwrappedQueryItems.count, 1)
        XCTAssertEqual(unwrappedQueryItems.first?.value, "2")
    }
    
    func test_appendPath_with_empty_path() {
        let builder = URLComponentsBuilder()
        builder.appendPath("")
        XCTAssertEqual(builder.urlComponents.path, "")
    }
    
    func test_appendPath_with_no_old_path() {
        let builder = URLComponentsBuilder()
        builder.appendPath("new")
        XCTAssertEqual(builder.urlComponents.path, "/new")
    }
    
    func test_appendPath_with_old_and_new_path() {
        let builder = URLComponentsBuilder()
        builder.urlComponents.path = "/old"
        builder.appendPath("new")
        XCTAssertEqual(builder.urlComponents.path, "/old/new")
    }
    
    func test_formatPath_without_slash() {
        let builder = URLComponentsBuilder()
        builder.appendPath("v2")
        XCTAssertEqual(builder.urlComponents.path, "/v2")
    }
    
    func test_formatPath_with_slash_at_end() {
        let builder = URLComponentsBuilder()
        builder.appendPath("v2/")
        XCTAssertEqual(builder.urlComponents.path, "/v2")
    }
    
    func test_formatPath_with_slash_at_front() {
        let builder = URLComponentsBuilder()
        builder.appendPath("/v2")
        XCTAssertEqual(builder.urlComponents.path, "/v2")
    }
}
