import Foundation
import OpenAPIURLSession

enum APIConfig {
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "YandexAPIKey") as? String ?? ""

    static func makeClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }
}
