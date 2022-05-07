import Combine
import Moya
import CombineMoya
@testable import AliasChallenge

final class MockPhotoService: GalleryServiceType {
    
    private let api =  MoyaProvider<GalleryApi>()
    
    func getAll(text: String, page: Int) -> AnyPublisher<PhotoResponseModel, Error> {
        api.requestPublisher(.all(text: text, page: page))
    }
    
    func getBy(id: String) -> AnyPublisher<DetailPhotoResponseModel, Error> {
        api.requestPublisher(.by(id: id))
    }
}
