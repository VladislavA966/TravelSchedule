import Foundation

@Observable
final class MainViewModel {
    var from: RoutePoint?
    var to: RoutePoint?
    var activeField: DirectionField?

    var canSearch: Bool {
        from != nil && to != nil
    }

    var query: TripQuery? {
        guard let from, let to else { return nil }
        return TripQuery(from: from, to: to)
    }

    func select(_ point: RoutePoint, for field: DirectionField) {
        switch field {
        case .from: from = point
        case .to: to = point
        }
        activeField = nil
    }

    func swap() {
        (from, to) = (to, from)
    }
}
