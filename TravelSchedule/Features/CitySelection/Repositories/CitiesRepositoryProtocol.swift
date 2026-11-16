import Foundation

protocol CitiesRepositoryProtocol {
    func fetchCities() async throws -> [City]
}
