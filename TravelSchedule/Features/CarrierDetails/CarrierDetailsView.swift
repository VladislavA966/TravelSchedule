import SwiftUI

struct CarrierDetailsView: View {
    @StateObject private var viewModel: CarrierDetailsViewModel
    @Environment(Router<ScheduleRoute>.self) private var router

    init(carrier: Carrier) {
        _viewModel = StateObject(wrappedValue: CarrierDetailsViewModel(carrier: carrier))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .s16) {
                logo

                Text(viewModel.carrier.title)
                    .font(.ypBold24)
                    .foregroundStyle(.ypBlack)

                VStack(alignment: .leading, spacing: 0) {
                    if let emailURL = viewModel.emailURL {
                        ContactRow(
                            title: .carrierDetailsEmail,
                            value: viewModel.carrier.email,
                            url: emailURL
                        )
                    }
                    if let phoneURL = viewModel.phoneURL {
                        ContactRow(
                            title: .carrierDetailsPhone,
                            value: viewModel.carrier.phone,
                            url: phoneURL
                        )
                    }
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
        AsyncImage(url: viewModel.carrier.logoURL) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
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
