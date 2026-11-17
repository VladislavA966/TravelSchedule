import SwiftUI

struct CarrierDetailsView: View {
    let carrier: Carrier
    @Environment(Router<ScheduleRoute>.self) private var router

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .s16) {
                logo

                Text(carrier.title)
                    .font(.ypBold24)
                    .foregroundStyle(.ypBlack)

                VStack(alignment: .leading, spacing: 0) {
                    ContactRow(
                        title: .carrierDetailsEmail,
                        value: carrier.email,
                        url: URL(string: "mailto:\(carrier.email)")
                    )
                    ContactRow(
                        title: .carrierDetailsPhone,
                        value: carrier.phone,
                        url: URL(string: "tel:\(carrier.phone.filter { $0.isNumber || $0 == "+" })")
                    )
                }
            }
            .padding(.horizontal, .s16)
            .padding(.top, .s16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.ypWhite)
        .navigationBar(title: .carrierDetailsTitle, onBack: router.pop)
    }

    private var logo: some View {
        Group {
            if let largeLogo = carrier.largeLogo {
                Image(largeLogo)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(carrier.logo)
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: LayoutConstants.logoHeight)
        .clipShape(RoundedRectangle(cornerRadius: .s24))
    }
}

private struct ContactRow: View {
    let title: LocalizedStringResource
    let value: String
    let url: URL?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.ypRegular17)
                .foregroundStyle(.ypBlack)

            if let url {
                Link(value, destination: url)
                    .font(.ypRegular12)
                    .foregroundStyle(.ypBlue)
            } else {
                Text(value)
                    .font(.ypRegular12)
                    .foregroundStyle(.ypBlue)
            }
        }
        .lineLimit(1)
        .frame(maxWidth: .infinity, minHeight: .s60, alignment: .leading)
    }
}

private enum LayoutConstants {
    static let logoHeight: CGFloat = 104
}

#Preview {
    NavigationStack {
        CarrierDetailsView(carrier: MockData.rzd)
    }
    .environment(Router<ScheduleRoute>())
}
