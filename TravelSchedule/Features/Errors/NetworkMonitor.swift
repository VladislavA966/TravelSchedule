import Network
import Observation

@MainActor
@Observable
final class NetworkMonitor {
    private(set) var isConnected = true

    @ObservationIgnored
    private let monitor = NWPathMonitor()

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            let isConnected = path.status == .satisfied
            MainActor.assumeIsolated {
                self?.isConnected = isConnected
            }
        }
        monitor.start(queue: .main)
    }

    deinit {
        monitor.cancel()
    }
}
