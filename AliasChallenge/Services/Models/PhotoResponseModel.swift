import Foundation

// MARK: - PhotoResponseModel
struct PhotoResponseModel: Codable {
    let photos: Photos
}

// MARK: - Photos
struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable, Identifiable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    
    /// MARK: Functions
    func getImageUrl(size: String) -> String {
        "\(Constants.baseUrlImage)/\(server)/\(id)_\(secret)_\(size).jpg"
    }
}
