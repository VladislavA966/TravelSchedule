import Foundation

protocol TripsRepositoryProtocol {
    func fetchTrips(for query: TripQuery) async throws -> [Trip]
}
