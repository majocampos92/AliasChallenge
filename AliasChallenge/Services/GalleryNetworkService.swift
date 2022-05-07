import Moya
import CombineMoya
import Combine

// MARK: - Protocols
protocol GalleryServiceType {
    func getAll(text: String, page: Int) -> AnyPublisher<PhotoResponseModel, Error>
    func getBy(id: String) -> AnyPublisher<DetailPhotoResponseModel, Error>
}

// MARK: - Networking Services 
struct GalleryNetworkService: GalleryServiceType {
    
    private let api =  MoyaProvider<GalleryApi>()

    func getAll(text: String, page: Int) -> AnyPublisher<PhotoResponseModel, Error> {
        api.requestPublisher(.all(text: text, page: page))
    }
    
    func getBy(id: String) -> AnyPublisher<DetailPhotoResponseModel, Error> {
        api.requestPublisher(.by(id: id))
    }
    
}
