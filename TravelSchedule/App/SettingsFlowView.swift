import SwiftUI

enum SettingsRoute: Hashable {
    case userAgreement
}

struct SettingsFlowView: View {
    @State private var router = Router<SettingsRoute>()

    var body: some View {
        NavigationStack(path: $router.path) {
            SettingsView()
                .navigationDestination(for: SettingsRoute.self) { route in
                    destination(for: route)
                        .toolbar(.hidden, for: .tabBar)
                }
        }
        .errorState()
        .environment(router)
    }

    @ViewBuilder
    private func destination(for route: SettingsRoute) -> some View {
        switch route {
        case .userAgreement:
            UserAgreementView()
        }
    }
}
