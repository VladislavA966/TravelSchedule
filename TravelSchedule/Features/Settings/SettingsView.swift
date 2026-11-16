import SwiftUI

struct SettingsView: View {
    @AppStorage(AppSettingsKeys.theme) private var theme = AppTheme.light
    @Environment(Router<SettingsRoute>.self) private var router

    var body: some View {
        VStack(spacing: 0) {
            Toggle(isOn: isDarkTheme) {
                Text(.settingsDarkTheme)
                    .font(.ypRegular17)
                    .foregroundStyle(.ypBlack)
            }
            .tint(.ypBlue)
            .frame(height: .s60)

            Button {
                router.push(.userAgreement)
            } label: {
                ChevronRow(title: .settingsUserAgreement)
            }
            .buttonStyle(.plain)

            Spacer()

            VStack(spacing: .s16) {
                Text(.settingsApiInfo)
                Text(.settingsVersion(Bundle.main.appVersion))
            }
            .font(.ypRegular12)
            .foregroundStyle(.ypBlack)
            .multilineTextAlignment(.center)
            .padding(.bottom, .s24)
        }
        .padding(.horizontal, .s16)
        .padding(.top, .s24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ypWhite)
    }

    private var isDarkTheme: Binding<Bool> {
        Binding(
            get: { theme == .dark },
            set: { theme = $0 ? .dark : .light }
        )
    }
}

private extension Bundle {
    var appVersion: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environment(Router<SettingsRoute>())
}
