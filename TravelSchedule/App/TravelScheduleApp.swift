import SwiftUI

@main
struct TravelScheduleApp: App {
    @State private var networkMonitor = NetworkMonitor()
    @AppStorage(AppSettingsKeys.theme) private var theme = AppTheme.light

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(networkMonitor)
                .preferredColorScheme(theme.colorScheme)
        }
    }
}
