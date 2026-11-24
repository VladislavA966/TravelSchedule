import Combine
import Foundation

@MainActor
final class FiltersViewModel: ObservableObject {
    @Published private(set) var draft: TripFilter
    private let initialFilter: TripFilter

    init(filter: TripFilter) {
        self.initialFilter = filter
        self.draft = filter
    }

    var canApply: Bool {
        draft != initialFilter
    }

    func isSelected(_ time: DepartureTime) -> Bool {
        draft.departureTimes.contains(time)
    }

    func setSelected(_ isSelected: Bool, for time: DepartureTime) {
        if isSelected {
            draft.departureTimes.insert(time)
        } else {
            draft.departureTimes.remove(time)
        }
    }

    func setShowTransfers(_ showTransfers: Bool) {
        draft.showTransfers = showTransfers
    }
}
