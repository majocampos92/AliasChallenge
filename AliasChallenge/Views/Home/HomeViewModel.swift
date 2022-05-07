import Foundation
import Combine

final class HomeViewModel: ObservableObject {
// MARK: - Proporties
    @Published var photos: [Photo] = []
    @Published private(set) var showEmptyState = false
    @Published var contact = Constants.empty
    @Published var error: Error?
    @Published var sucessPresented = true
    
    var galleryComplete = false
    private var currentPage = Constants.zero
    private let galleryService: GalleryServiceType
    private var page = Constants.initialPage
    private var cancellable = Set<AnyCancellable>()

// MARK: - Initialization
    init(galleryService: GalleryServiceType) {
        self.galleryService = galleryService
    }
// MARK: - Methods
    func reload() {
        page = Constants.initialPage
        photos.removeAll()
        getPhotos()
    }
    
    func loadMorePhotos() {
        page += 1
        getPhotos()
    }
    
    func getPhotos() {
        galleryService.getAll(text: contact, page: page)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let failure):
                    self.error = failure
                    print("ERROR GET PHOTOS: \(failure)!!")
                case .finished:
                    self.sucessPresented = true
                }
            }, receiveValue: { response in
                let photo = response.photos.photo
                self.photos.append(contentsOf: photo)
                self.showEmptyState = photo.isEmpty
                self.currentPage += Constants.galleryLimitPerPage
                self.galleryComplete = response.photos.pages < self.page
            }
        )
        .store(in: &cancellable)
    }
}
// MARK: - Extensions 
extension HomeViewModel {
    static func make() -> HomeViewModel {
        HomeViewModel(galleryService: Injector.resolve(GalleryServiceType.self))
    }
}
