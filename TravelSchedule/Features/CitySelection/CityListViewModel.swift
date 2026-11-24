import Combine
import Foundation

@MainActor
final class CityListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private(set) var isLoading = false
    @Published private(set) var error: AppError?
    @Published private var cities: [City] = []

    private let repository: CitiesRepositoryProtocol

    init(repository: CitiesRepositoryProtocol = AppDependencies.citiesRepository) {
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
