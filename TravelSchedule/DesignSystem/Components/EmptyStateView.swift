import SwiftUI

struct EmptyStateView: View {
    let text: LocalizedStringResource

    var body: some View {
        Text(text)
            .font(.ypBold24)
            .foregroundStyle(.ypBlack)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(text: .carriersEmpty)
}
