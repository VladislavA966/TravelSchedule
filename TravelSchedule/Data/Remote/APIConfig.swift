import Foundation
import OpenAPIURLSession

enum APIConfig {
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "YandexAPIKey") as? String ?? ""

    static func makeScheduleClient() throws -> YandexScheduleClient {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        return YandexScheduleClient(client: client, apikey: apiKey)
    }
}
