import Foundation

enum DepartureTime: CaseIterable, Hashable {
    case morning
    case day
    case evening
    case night

    var title: LocalizedStringResource {
        switch self {
        case .morning: .departureTimeMorning
        case .day: .departureTimeDay
        case .evening: .departureTimeEvening
        case .night: .departureTimeNight
        }
    }

    func contains(hour: Int) -> Bool {
        switch self {
        case .morning: (6..<12).contains(hour)
        case .day: (12..<18).contains(hour)
        case .evening: (18..<24).contains(hour)
        case .night: (0..<6).contains(hour)
        }
    }
}
