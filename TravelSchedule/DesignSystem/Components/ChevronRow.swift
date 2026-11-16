import SwiftUI

struct ChevronRow: View {
    private let title: Text

    init(title: String) {
        self.title = Text(verbatim: title)
    }

    init(title: LocalizedStringResource) {
        self.title = Text(title)
    }

    var body: some View {
        HStack {
            title
                .font(.ypRegular17)
                .foregroundStyle(.ypBlack)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.ypSemibold17)
                .foregroundStyle(.ypBlack)
        }
        .frame(height: .s60)
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack(spacing: 0) {
        ChevronRow(title: "Москва")
        ChevronRow(title: .settingsUserAgreement)
    }
    .padding(.horizontal)
}
