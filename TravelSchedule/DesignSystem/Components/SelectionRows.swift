import SwiftUI

struct CheckboxRow: View {
    let title: LocalizedStringResource
    @Binding var isOn: Bool

    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            HStack {
                Text(title)
                    .font(.ypRegular17)
                    .foregroundStyle(.ypBlack)
                Spacer()
                Image(systemName: isOn ? "checkmark.square.fill" : "square")
                    .font(.ypRegular22)
                    .foregroundStyle(.ypBlack)
            }
            .frame(height: .s60)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct RadioRow: View {
    let title: LocalizedStringResource
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.ypRegular17)
                    .foregroundStyle(.ypBlack)
                Spacer()
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .font(.ypRegular22)
                    .foregroundStyle(.ypBlack)
            }
            .frame(height: .s60)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var isOn = true
    VStack(spacing: 0) {
        CheckboxRow(title: .departureTimeMorning, isOn: $isOn)
        RadioRow(title: .filtersYes, isSelected: true) {}
        RadioRow(title: .filtersNo, isSelected: false) {}
    }
    .padding(.horizontal)
}
