import Testing
@testable import TravelSchedule

struct TripFilterTests {
    private let directTrip = MockData.trips[1]
    private let transferTrip = MockData.trips[0]

    @Test func emptyFilterMatchesAllTrips() {
        let filter = TripFilter()

        #expect(!filter.isActive)
        #expect(filter.matches(directTrip))
        #expect(filter.matches(transferTrip))
    }

    @Test func hidesTripsWithTransfers() {
        let filter = TripFilter(showTransfers: false)

        #expect(filter.matches(directTrip))
        #expect(!filter.matches(transferTrip))
    }

    @Test func filtersByDepartureTime() {
        let filter = TripFilter(departureTimes: [.night])

        #expect(filter.matches(directTrip))
        #expect(!filter.matches(transferTrip))
    }
}

@MainActor
struct MainViewModelTests {
    private let moscow = RoutePoint(city: MockData.cities[0], station: MockData.cities[0].stations[0])
    private let spb = RoutePoint(city: MockData.cities[1], station: MockData.cities[1].stations[0])

    @Test func searchRequiresBothPoints() {
        let viewModel = MainViewModel()
        viewModel.select(moscow, for: .from)

        #expect(viewModel.query == nil)

        viewModel.select(spb, for: .to)

        #expect(viewModel.query == TripQuery(from: moscow, to: spb))
    }

    @Test func swapExchangesPoints() {
        let viewModel = MainViewModel()
        viewModel.select(moscow, for: .from)
        viewModel.select(spb, for: .to)

        viewModel.swap()

        #expect(viewModel.from == spb)
        #expect(viewModel.to == moscow)
    }
}
