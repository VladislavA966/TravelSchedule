import Combine
import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var isDarkTheme: Bool {
        didSet {
            let theme: AppTheme = isDarkTheme ? .dark : .light
            defaults.set(theme.rawValue, forKey: AppSettingsKeys.theme)
        }
    }

    let appVersion: String

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard, bundle: Bundle = .main) {
        self.defaults = defaults
        let storedTheme = defaults.string(forKey: AppSettingsKeys.theme).flatMap(AppTheme.init(rawValue:))
        self.isDarkTheme = storedTheme == .dark
        self.appVersion = bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}
