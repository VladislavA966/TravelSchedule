import Combine
import Foundation

@MainActor
final class RootViewModel: ObservableObject {
    @Published private(set) var isSplashShown = true

    func prepare() async {
        try? await Task.sleep(for: Constants.splashDuration)
        isSplashShown = false
    }
}

private enum Constants {
    static let splashDuration: Duration = .seconds(2)
}
