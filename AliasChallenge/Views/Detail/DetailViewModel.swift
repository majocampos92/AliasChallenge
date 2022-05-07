import Foundation
import Combine

final class DetailViewModel: ObservableObject{
// MARK: - Properties
    @Published private(set) var photo: DetailPhoto?
    @Published var error: Error?
    @Published var sucessPresented = true
    
    private let galleryService: GalleryServiceType
    private var cancellable = Set<AnyCancellable>()
    
// MARK: - Initialization
    init(galleryService: GalleryServiceType) {
        self.galleryService = galleryService
    }
    
// MARK: - Methods
    func getDetailPhoto(id: String) {
        galleryService.getBy(id: id)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let failure):
                        self.error = failure
                        print("ERROR GET DETAIL: \(failure)!!")
                    case .finished:
                        self.sucessPresented = true
                    }
                }, receiveValue: { response in
                    self.photo = DetailPhoto(
                        name: response.photo.owner?.realname ?? Constants.empty,
                        date: response.photo.dates.taken,
                        description: response.photo.description.content
                    )
                }
            )
            .store(in: &cancellable)
    }
}

// MARK: - Extensions 
extension DetailViewModel {
    static func make() -> DetailViewModel {
        DetailViewModel(galleryService: Injector.resolve(GalleryServiceType.self))
    }
}
