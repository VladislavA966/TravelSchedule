import SwiftUI

struct ChevronRow: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
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
        ChevronRow(title: "Санкт-Петербург")
    }
    .padding(.horizontal)
}
