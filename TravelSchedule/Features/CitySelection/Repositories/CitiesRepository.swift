import Foundation

actor CitiesRepository: CitiesRepositoryProtocol {
    private let client: YandexScheduleClient
    private var loadTask: Task<[City], Error>?

    init(client: YandexScheduleClient) {
        self.client = client
    }

    func fetchCities() async throws -> [City] {
        if let loadTask {
            return try await loadTask.value
        }

        let task = Task { [client] in
            let response = try await client.getAllStations()
            return Self.makeCities(from: response)
        }
        loadTask = task

        do {
            return try await task.value
        } catch {
            loadTask = nil
            throw error
        }
    }

    private static func makeCities(from response: AllStations) -> [City] {
        let russia = response.countries?.first { $0.title == Constants.countryTitle }
        let settlements = russia?.regions?.flatMap { $0.settlements ?? [] } ?? []

        return settlements
            .compactMap(makeCity)
            .sorted { lhs, rhs in
                lhs.stations.count != rhs.stations.count
                    ? lhs.stations.count > rhs.stations.count
                    : lhs.title < rhs.title
            }
    }

    private static func makeCity(from settlement: Components.Schemas.Settlement) -> City? {
        guard
            let title = settlement.title, !title.isEmpty,
            let code = settlement.codes?.yandexCode
        else { return nil }

        var seenCodes = Set<String>()
        let stations = (settlement.stations ?? [])
            .filter { $0.transportType == Constants.transportType }
            .compactMap(makeStation)
            .filter { seenCodes.insert($0.id).inserted }

        guard !stations.isEmpty else { return nil }
        return City(id: code, title: title, stations: stations)
    }

    private static func makeStation(from station: Components.Schemas.StationsListStation) -> Station? {
        guard
            let title = station.title, !title.isEmpty,
            let code = station.codes?.yandexCode
        else { return nil }
        return Station(id: code, title: title)
    }
}

private enum Constants {
    static let countryTitle = "Россия"
    static let transportType = "train"
}
