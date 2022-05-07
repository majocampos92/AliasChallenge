import Foundation

enum Constants {
    ///response
    static let baseUrl = "https://www.flickr.com//services/rest"
    static let baseUrlImage = "https://live.staticflickr.com"
    static let key = "c19cdd069d071972790f0513ecb5264e"
    static let format = "json"
    static let w = "w"
    static let n = "n"
    static let z = "z"
    static let zero = 0
    static let initialPage = 1
    static let noJsonCallBack = 1
    static let galleryLimitPerPage = 15
    static let skeletonQuantityPreview = 12
    
    ///view
    static let padding = 5.0
    static let lineLimit = 1
    static let cornerRadius = 5.0
    static let opacityButton = 1.0
    static let heightButtomSheet = 3
    static let galleryGridColumns = 3
    static let opacityButtomSheet = 0.5
    static let galleryCardSpacing = 1.0
    static let sectionCardSpacing = 15.0
    
    ///text in views
    static let empty = ""
    static let owner = "Owner"
    static let takenAt = "Taken at"
    static let notFound = "Not found"
    static let homeTitle = "Alias Challenge"
    static let searchInput = "Search a name"
    static let emptyState = "No results found..."
    static let buttonLinkLabel = "Open in browser"
    static let errorBaseUrl = "baseURL could not be configurated."
    static let homeSearch = "Find Flick photos by searching names in the search bar below"
}
