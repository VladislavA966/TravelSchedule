import Combine
import Foundation

@MainActor
final class CarriersViewModel: ObservableObject {
    let query: TripQuery
    @Published private(set) var trips: [Trip] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: AppError?

    private let repository: TripsRepositoryProtocol

    init(query: TripQuery, repository: TripsRepositoryProtocol = AppDependencies.tripsRepository) {
        self.query = query
        self.repository = repository
    }

    var title: String {
        "\(query.from.title) → \(query.to.title)"
    }

    func filteredTrips(by filter: TripFilter) -> [Trip] {
        trips.filter(filter.matches)
    }

    func load() async {
        guard trips.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            trips = try await repository.fetchTrips(for: query)
            error = nil
        } catch {
            self.error = .server
        }
    }
}
