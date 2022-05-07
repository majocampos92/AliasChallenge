import XCTest
@testable import AliasChallenge

class DetailViewModelTest: XCTestCase {
    
    var viewModel: DetailViewModel!
    var mockPhotoService: MockPhotoService!
    
    override func setUpWithError() throws {
        mockPhotoService = MockPhotoService()
        viewModel = .init(galleryService: mockPhotoService)
    }
    
    func testGetPhotoDetailWhithCorrectResponse() {
        viewModel.getDetailPhoto(id: "52034866254")

        XCTAssert(viewModel.sucessPresented)
    }
    
    func testGetPhotoDetailWhithSetsError() {
        viewModel.getDetailPhoto(id: "52034866254")
        
        XCTAssertNil(viewModel.error)
        
    }
}
