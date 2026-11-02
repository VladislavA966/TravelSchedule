import Foundation

@Observable
final class CityListViewModel {
    var searchText = ""
    private(set) var isLoading = false
    private(set) var error: AppError?
    private var cities: [City] = []

    private let repository: CitiesRepositoryProtocol

    init(repository: CitiesRepositoryProtocol = MockCitiesRepository()) {
        self.repository = repository
    }

    var filteredCities: [City] {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return cities }
        return cities.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }

    func load() async {
        guard cities.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            cities = try await repository.fetchCities()
            error = nil
        } catch {
            self.error = .server
        }
    }
}
