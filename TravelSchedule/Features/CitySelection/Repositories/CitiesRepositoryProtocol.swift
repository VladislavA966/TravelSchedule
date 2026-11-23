import Foundation

protocol CitiesRepositoryProtocol: Sendable {
    func fetchCities() async throws -> [City]
}
