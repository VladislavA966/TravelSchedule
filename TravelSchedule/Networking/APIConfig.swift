import Foundation
import OpenAPIURLSession

enum APIConfig {
    static let apiKey = "4933c663-ee99-419f-9a00-4bd53092057c"

    static func makeClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }
}
