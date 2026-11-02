import SwiftUI

struct RootView: View {
    private static let splashDuration: Duration = .seconds(2)

    @State private var isSplashShown = true

    var body: some View {
        ZStack {
            if isSplashShown {
                SplashView()
                    .transition(.opacity)
            } else {
                MainTabView()
            }
        }
        .task {
            try? await Task.sleep(for: Self.splashDuration)
            withAnimation {
                isSplashShown = false
            }
        }
    }
}

#Preview {
    RootView()
        .environment(NetworkMonitor())
}
