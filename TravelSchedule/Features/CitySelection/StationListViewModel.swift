import Combine
import Foundation

@MainActor
final class StationListViewModel: ObservableObject {
    @Published var searchText = ""
    private let city: City

    init(city: City) {
        self.city = city
    }

    var filteredStations: [Station] {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return city.stations }
        return city.stations.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }
}
