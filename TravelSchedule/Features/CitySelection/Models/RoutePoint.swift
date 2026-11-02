import Foundation

struct RoutePoint: Hashable {
    let city: City
    let station: Station

    var title: String {
        "\(city.title) (\(station.title))"
    }
}
