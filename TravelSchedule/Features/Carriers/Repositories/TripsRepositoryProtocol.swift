import Foundation

protocol TripsRepositoryProtocol: Sendable {
    func fetchTrips(for query: TripQuery) async throws -> [Trip]
}
