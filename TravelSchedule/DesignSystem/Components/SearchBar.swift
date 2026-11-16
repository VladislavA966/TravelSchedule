import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: LocalizedStringResource = .searchPlaceholder

    var body: some View {
        HStack(spacing: .s8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(text.isEmpty ? .ypGray : .ypBlack)

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder).foregroundStyle(.ypGray)
            )
            .font(.ypRegular17)
            .foregroundStyle(.ypBlack)
            .autocorrectionDisabled()

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.ypGray)
                }
            }
        }
        .padding(.horizontal, .s8)
        .frame(height: .s36)
        .background(.ypLightGray.opacity(Layout.backgroundOpacity), in: RoundedRectangle(cornerRadius: .s10))
    }
}

private enum Layout {
    static let backgroundOpacity = 0.5
}

#Preview {
    @Previewable @State var text = ""
    SearchBar(text: $text)
        .padding()
}
