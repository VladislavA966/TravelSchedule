import SwiftUI

@main
struct TravelScheduleApp: App {
    @State private var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(networkMonitor)
        }
    }
}
