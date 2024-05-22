@testable import NetSwiftly
import XCTest

final class PaginatedURLRequestCommandCreatorTests: XCTestCase {

    func test_zero() throws {
        let networkConfiguration = NetworkConfiguration.fixture()
        let endpoint = Endpoint.fixture()
        let paginationQueryStrategy = PageBasedQueryStrategy.fixture()
        
        let sut: PaginatedURLRequestCommand<TestStruct> = makePaginatedURLRequestCommand(networkConfiguration: networkConfiguration, endpoint: endpoint, paginationQueryStrategy: paginationQueryStrategy)
        
        XCTAssertIdentical(sut.urlRequestDirector.endpoint, endpoint)
        XCTAssertIdentical(sut.urlRequestDirector.networkConfiguration, networkConfiguration)
        guard let paginatedURLRequestDirector = sut.urlRequestDirector as? PaginatedURLRequestDirector else {
            XCTFail("got wrong urlRequestDirector type")
            return
        }
        
        guard let paginationQueryStrategyInSut = paginatedURLRequestDirector.paginationQueryStrategy as? PageBasedQueryStrategy else {
            XCTFail("got wrong paginationQueryStrategy type")
            return
        }
        XCTAssertIdentical(paginationQueryStrategyInSut, paginationQueryStrategy)
    }
}
