import Foundation

nonisolated struct RoutePoint: Hashable, Sendable {
    let city: City
    let station: Station

    var title: String {
        "\(city.title) (\(station.title))"
    }
}
