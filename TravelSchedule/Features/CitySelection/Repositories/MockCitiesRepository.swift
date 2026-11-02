import Foundation

final class MockCitiesRepository: CitiesRepositoryProtocol {
    func fetchCities() async throws -> [City] {
        MockData.cities
    }
}
