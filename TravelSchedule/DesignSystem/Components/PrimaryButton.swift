import SwiftUI

struct PrimaryButton: View {
    let title: LocalizedStringResource
    var showsIndicator = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: .s4) {
                Text(title)
                    .font(.ypBold17)
                if showsIndicator {
                    Circle()
                        .fill(.ypRed)
                        .frame(width: .s8, height: .s8)
                }
            }
            .foregroundStyle(.ypWhiteUniversal)
            .frame(maxWidth: .infinity)
            .frame(height: .s60)
            .background(.ypBlue, in: RoundedRectangle(cornerRadius: .s16))
        }
    }
}

#Preview {
    VStack {
        PrimaryButton(title: .mainSearch) {}
        PrimaryButton(title: .carriersFilterButton, showsIndicator: true) {}
    }
    .padding()
}
