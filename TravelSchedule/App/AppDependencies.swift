import Foundation

enum AppDependencies {
    static let scheduleClient = APIConfig.makeScheduleClient()
    static let citiesRepository: CitiesRepositoryProtocol = CitiesRepository(client: scheduleClient)
    static let tripsRepository: TripsRepositoryProtocol = TripsRepository(client: scheduleClient)
}
