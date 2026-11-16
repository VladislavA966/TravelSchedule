import Foundation

struct TripFilter: Hashable {
    var departureTimes: Set<DepartureTime> = []
    var showTransfers: Bool?

    var isActive: Bool {
        !departureTimes.isEmpty || showTransfers != nil
    }

    func matches(_ trip: Trip) -> Bool {
        let matchesTime = departureTimes.isEmpty
            || departureTimes.contains { $0.contains(hour: trip.departureHour) }
        let matchesTransfers = showTransfers != false || trip.transferCity == nil
        return matchesTime && matchesTransfers
    }
}
