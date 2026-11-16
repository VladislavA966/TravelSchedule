import Foundation

final class MockTripsRepository: TripsRepositoryProtocol {
    func fetchTrips(for query: TripQuery) async throws -> [Trip] {
        MockData.trips
    }
}
