import Foundation

@Observable
final class CarriersViewModel {
    let query: TripQuery
    private(set) var trips: [Trip] = []
    private(set) var isLoading = false
    private(set) var error: AppError?

    private let repository: TripsRepositoryProtocol

    init(query: TripQuery, repository: TripsRepositoryProtocol = MockTripsRepository()) {
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
