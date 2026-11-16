import SwiftUI

struct SettingsView: View {
    var body: some View {
        Text(.settingsTitle)
            .font(.ypBold24)
            .foregroundStyle(.ypBlack)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ypWhite)
            .errorState()
    }
}

#Preview {
    SettingsView()
        .environment(NetworkMonitor())
}
