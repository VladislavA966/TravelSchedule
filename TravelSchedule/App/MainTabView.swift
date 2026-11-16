import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ScheduleFlowView()
                .tabItem {
                    Image(systemName: "arrow.up.message.fill")
                }

            SettingsFlowView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
        }
        .tint(.ypBlack)
    }
}

#Preview {
    MainTabView()
        .environment(NetworkMonitor())
}
