import Foundation

enum AppError: Error, Hashable {
    case server
    case noInternet

    var title: LocalizedStringResource {
        switch self {
        case .server: .errorServer
        case .noInternet: .errorNoInternet
        }
    }

    var imageName: String {
        switch self {
        case .server: "ServerError"
        case .noInternet: "NoInternet"
        }
    }
}
