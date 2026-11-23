import Foundation
import OpenAPIURLSession

enum APIConfig {
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "YandexAPIKey") as? String ?? ""
    static let serverURL = URL(string: "https://api.rasp.yandex.net")!

    static func makeScheduleClient() -> YandexScheduleClient {
        let client = Client(serverURL: serverURL, transport: URLSessionTransport())
        return YandexScheduleClient(client: client, apikey: apiKey)
    }
}
