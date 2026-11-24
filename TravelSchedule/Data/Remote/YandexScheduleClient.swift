import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Segments = Components.Schemas.Segments
typealias ScheduleResponse = Components.Schemas.ScheduleResponse
typealias ThreadStations = Components.Schemas.ThreadStationsResponse
typealias NearestStations = Components.Schemas.Stations
typealias NearestCity = Components.Schemas.NearestCityResponse
typealias CarrierInfo = Components.Schemas.CarrierResponse
typealias AllStations = Components.Schemas.AllStationsResponse
typealias Copyright = Components.Schemas.CopyrightResponse

actor YandexScheduleClient {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getScheduleBetweenStations(
        from: String,
        to: String,
        date: String? = nil,
        transfers: Bool? = nil
    ) async throws -> Segments {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date,
            transfers: transfers
        ))
        return try response.ok.body.json
    }

    func getStationSchedule(station: String, date: String? = nil) async throws -> ScheduleResponse {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station,
            date: date
        ))
        return try response.ok.body.json
    }

    func getRouteStations(uid: String) async throws -> ThreadStations {
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid
        ))
        return try response.ok.body.json
    }

    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }

    func getNearestCity(lat: Double, lng: Double, distance: Int? = nil) async throws -> NearestCity {
        let response = try await client.getNearestCity(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }

    func getCarrierInfo(code: String, system: String? = nil) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code,
            system: system
        ))
        return try response.ok.body.json
    }

    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init(apikey: apikey))
        let body = try response.ok.body.html
        let data = try await Data(collecting: body, upTo: Constants.allStationsSizeLimit)
        return try JSONDecoder().decode(AllStations.self, from: data)
    }

    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(apikey: apikey))
        return try response.ok.body.json
    }
}

private enum Constants {
    static let allStationsSizeLimit = 100 * 1024 * 1024
}
