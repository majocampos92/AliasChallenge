import Moya
import Foundation

enum GalleryApi {
    case all(text: String, page: Int)
    case by(id: String)
}
// MARK: Extensions
extension GalleryApi: TargetType {
// MARK: - Proporties 
    var baseURL: URL {
        guard let url = URL(string: Constants.baseUrl) else {
            fatalError(Constants.errorBaseUrl)
        }
        return url
    }
    
    var path: String {
        "/"
    }
    
    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .all(let text, let page):
            return .requestParameters(
                parameters: [
                    Keys.method: Endpoints.get,
                    Keys.apiKey: Constants.key,
                    Keys.page: page,
                    Keys.perPage: Constants.galleryLimitPerPage,
                    Keys.text: text,
                    Keys.format: Constants.format,
                    Keys.noJsonCallBack: Constants.noJsonCallBack
                ],
                encoding: URLEncoding.default
            )
        case .by(id: let id):
            return .requestParameters(
                parameters: [
                    Keys.method: Endpoints.by,
                    Keys.apiKey: Constants.key,
                    Keys.photoId: id,
                    Keys.format: Constants.format,
                    Keys.noJsonCallBack: Constants.noJsonCallBack
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
