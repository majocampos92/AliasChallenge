import XCTest
@testable import AliasChallenge

class HomeViewModelTest: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockPhotoService: MockPhotoService!
    
    override func setUpWithError() throws {
        mockPhotoService = MockPhotoService()
        viewModel = .init(galleryService: mockPhotoService)
    }
    
    func testGetPhotosWhithCorrectResponse() {
        viewModel.getPhotos()

        XCTAssert(viewModel.sucessPresented)
    }
    
    func testGetPhotosWhithSetsError() {
        viewModel.getPhotos()
        
        XCTAssertNil(viewModel.error)
        
    }
}
