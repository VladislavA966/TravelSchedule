import Foundation

struct TripsRepository: TripsRepositoryProtocol {
    private let client: YandexScheduleClient

    init(client: YandexScheduleClient) {
        self.client = client
    }

    func fetchTrips(for query: TripQuery) async throws -> [Trip] {
        let response = try await client.getScheduleBetweenStations(
            from: query.from.station.id,
            to: query.to.station.id,
            date: Date.now.formatted(Formats.requestDate),
            transfers: true
        )
        return (response.segments ?? [])
            .enumerated()
            .compactMap { index, segment in TripMapper.makeTrip(from: segment, index: index) }
    }
}

private enum TripMapper {
    static func makeTrip(from segment: Components.Schemas.Segment, index: Int) -> Trip? {
        guard
            let departure = segment.departure.flatMap(DateTimeParts.init(iso:)),
            let arrival = segment.arrival.flatMap(DateTimeParts.init(iso:)),
            let carrier = carrier(of: segment).flatMap(makeCarrier)
        else { return nil }

        let transferCity = segment.hasTransfers == true
            ? segment.transfers?.first?.title
            : nil

        return Trip(
            id: "\(index)-\(segment.departure ?? "")",
            carrier: carrier,
            date: departure.day,
            departureTime: departure.time,
            arrivalTime: arrival.time,
            duration: formatDuration(segment.duration),
            transferCity: transferCity
        )
    }

    private static func carrier(of segment: Components.Schemas.Segment) -> Components.Schemas.Carrier? {
        segment.thread?.carrier
            ?? segment.details?.lazy.compactMap { $0.thread?.carrier }.first
    }

    private static func makeCarrier(from carrier: Components.Schemas.Carrier) -> Carrier? {
        guard let code = carrier.code, let title = carrier.title else { return nil }
        return Carrier(
            id: String(code),
            title: title,
            logoURL: carrier.logo.flatMap(URL.init(string:)),
            email: carrier.email ?? "",
            phone: carrier.phone ?? ""
        )
    }

    private static func formatDuration(_ seconds: Double?) -> String {
        guard let seconds else { return "" }
        return Duration.seconds(seconds).formatted(.units(allowed: [.hours], width: .wide))
    }
}

private struct DateTimeParts {
    let day: String
    let time: String

    init?(iso: String) {
        let parts = iso.split(separator: "T")
        guard
            parts.count == 2,
            let date = try? Date(String(parts[0]), strategy: Formats.isoDay)
        else { return nil }

        day = date.formatted(Formats.displayDay)
        time = String(parts[1].prefix(Formats.timeLength))
    }
}

private enum Formats {
    static let requestDate = Date.ISO8601FormatStyle(timeZone: .current).year().month().day()
    static let isoDay = Date.ISO8601FormatStyle(timeZone: .gmt).year().month().day()
    static let displayDay = Date.FormatStyle(timeZone: .gmt).day().month(.wide)
    static let timeLength = 5
}
