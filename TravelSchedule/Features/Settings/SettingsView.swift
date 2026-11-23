import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(Router<SettingsRoute>.self) private var router

    var body: some View {
        VStack(spacing: 0) {
            Toggle(isOn: $viewModel.isDarkTheme) {
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
                Text(.settingsVersion(viewModel.appVersion))
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
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environment(Router<SettingsRoute>())
}
