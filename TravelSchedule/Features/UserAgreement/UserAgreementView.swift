import SwiftUI

struct UserAgreementView: View {
    @StateObject private var viewModel = UserAgreementViewModel()
    @Environment(Router<SettingsRoute>.self) private var router

    var body: some View {
        WebView(url: viewModel.url, isLoading: $viewModel.isLoading, error: $viewModel.error)
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .background(.ypWhite)
            .navigationBar(title: .settingsUserAgreement, onBack: router.pop)
            .errorState(viewModel.error)
    }
}

#Preview {
    NavigationStack {
        UserAgreementView()
    }
    .environment(Router<SettingsRoute>())
    .environment(NetworkMonitor())
}
