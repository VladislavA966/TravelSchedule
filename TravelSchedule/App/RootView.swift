import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = RootViewModel()

    var body: some View {
        ZStack {
            if viewModel.isSplashShown {
                SplashView()
                    .transition(.opacity)
            } else {
                MainTabView()
            }
        }
        .animation(.default, value: viewModel.isSplashShown)
        .task {
            await viewModel.prepare()
        }
    }
}

#Preview {
    RootView()
        .environment(NetworkMonitor())
}
