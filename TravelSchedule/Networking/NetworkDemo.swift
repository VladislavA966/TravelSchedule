import Foundation

enum NetworkDemo {
    static func runAll() async {
        let client: Client
        do {
            client = try APIConfig.makeClient()
        } catch {
            print("❌ Не удалось создать клиент: \(error)")
            return
        }
        let apikey = APIConfig.apiKey

        await testFetchCopyright(client: client, apikey: apikey)
        await testFetchNearestStations(client: client, apikey: apikey)
        await testFetchNearestCity(client: client, apikey: apikey)
        let threadUID = await testFetchScheduleBetweenStations(client: client, apikey: apikey)
        await testFetchStationSchedule(client: client, apikey: apikey)
        await testFetchRouteStations(client: client, apikey: apikey, uid: threadUID)
        await testFetchCarrierInfo(client: client, apikey: apikey)
        await testFetchAllStations(client: client, apikey: apikey)
    }

    private static func testFetchCopyright(client: Client, apikey: String) async {
        do {
            let service = CopyrightService(client: client, apikey: apikey)
            let copyright = try await service.getCopyright()
            print("✅ copyright: \(copyright.copyright?.text ?? "-")")
        } catch {
            print("❌ copyright: \(error)")
        }
    }

    private static func testFetchNearestStations(client: Client, apikey: String) async {
        do {
            let service = NearestStationsService(client: client, apikey: apikey)
            let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print("✅ nearest_stations: \(stations.stations?.count ?? 0) станций, первая — \(stations.stations?.first?.title ?? "-")")
        } catch {
            print("❌ nearest_stations: \(error)")
        }
    }

    private static func testFetchNearestCity(client: Client, apikey: String) async {
        do {
            let service = NearestCityService(client: client, apikey: apikey)
            let city = try await service.getNearestCity(lat: 59.864177, lng: 30.319163, distance: 50)
            print("✅ nearest_settlement: \(city.title ?? "-") (\(city.code ?? "-"))")
        } catch {
            print("❌ nearest_settlement: \(error)")
        }
    }

    /// Возвращает uid первой нитки, чтобы использовать его в запросе thread
    private static func testFetchScheduleBetweenStations(client: Client, apikey: String) async -> String? {
        do {
            let service = ScheduleBetweenStationsService(client: client, apikey: apikey)
            // c213 — Москва, c2 — Санкт-Петербург
            let segments = try await service.getScheduleBetweenStations(from: "c213", to: "c2", date: nil)
            print("✅ search: \(segments.segments?.count ?? 0) рейсов Москва → Санкт-Петербург")
            return segments.segments?.first?.thread?.uid
        } catch {
            print("❌ search: \(error)")
            return nil
        }
    }

    private static func testFetchStationSchedule(client: Client, apikey: String) async {
        do {
            let service = StationScheduleService(client: client, apikey: apikey)
            // s9600213 — аэропорт Шереметьево
            let schedule = try await service.getStationSchedule(station: "s9600213", date: nil)
            print("✅ schedule: \(schedule.station?.title ?? "-"), \(schedule.schedule?.count ?? 0) рейсов")
        } catch {
            print("❌ schedule: \(error)")
        }
    }

    private static func testFetchRouteStations(client: Client, apikey: String, uid: String?) async {
        guard let uid else {
            print("⚠️ thread: нет uid нитки из search, запрос пропущен")
            return
        }
        do {
            let service = RouteStationsService(client: client, apikey: apikey)
            let thread = try await service.getRouteStations(uid: uid)
            print("✅ thread: \(thread.title ?? "-"), \(thread.stops?.count ?? 0) остановок")
        } catch {
            print("❌ thread: \(error)")
        }
    }

    private static func testFetchCarrierInfo(client: Client, apikey: String) async {
        do {
            let service = CarrierInfoService(client: client, apikey: apikey)
            // SU — Аэрофлот в системе IATA
            let info = try await service.getCarrierInfo(code: "SU", system: "iata")
            let title = info.carrier?.title ?? info.carriers?.first?.title ?? "-"
            print("✅ carrier: \(title)")
        } catch {
            print("❌ carrier: \(error)")
        }
    }

    private static func testFetchAllStations(client: Client, apikey: String) async {
        do {
            let service = AllStationsService(client: client, apikey: apikey)
            let allStations = try await service.getAllStations()
            print("✅ stations_list: \(allStations.countries?.count ?? 0) стран")
        } catch {
            print("❌ stations_list: \(error)")
        }
    }
}
