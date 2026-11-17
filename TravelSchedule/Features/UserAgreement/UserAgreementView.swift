import SwiftUI

struct UserAgreementView: View {
    @State private var isLoading = true
    @State private var error: AppError?
    @Environment(Router<SettingsRoute>.self) private var router

    var body: some View {
        WebView(url: Constants.agreementURL, isLoading: $isLoading, error: $error)
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
            .background(.ypWhite)
            .navigationBar(title: .settingsUserAgreement, onBack: router.pop)
            .errorState(error)
    }
}

private enum Constants {
    static let agreementURL = URL(string: "https://yandex.ru/legal/practicum_offer")!
}

#Preview {
    NavigationStack {
        UserAgreementView()
    }
    .environment(Router<SettingsRoute>())
    .environment(NetworkMonitor())
}
