import Foundation

struct TripQuery: Hashable, Sendable {
    let from: RoutePoint
    let to: RoutePoint
}
