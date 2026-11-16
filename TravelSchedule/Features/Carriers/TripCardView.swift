import SwiftUI
import UIKit

struct TripCardView: View {
    let trip: Trip

    var body: some View {
        VStack(spacing: .s4) {
            HStack(alignment: .top, spacing: .s8) {
                CarrierLogoView(carrier: trip.carrier)

                VStack(alignment: .leading, spacing: .s2) {
                    Text(trip.carrier.title)
                        .font(.ypRegular17)
                        .foregroundStyle(.ypBlackUniversal)
                    if let transferCity = trip.transferCity {
                        Text(.carriersTransfer(transferCity))
                            .font(.ypRegular12)
                            .foregroundStyle(.ypRed)
                    }
                }

                Spacer()

                Text(trip.date)
                    .font(.ypRegular12)
                    .foregroundStyle(.ypBlackUniversal)
                    .padding(.top, .s2)
            }

            HStack(spacing: .s4) {
                Text(trip.departureTime)
                    .font(.ypRegular17)
                divider
                Text(trip.duration)
                    .font(.ypRegular12)
                divider
                Text(trip.arrivalTime)
                    .font(.ypRegular17)
            }
            .foregroundStyle(.ypBlackUniversal)
            .frame(height: .s48)
        }
        .padding([.top, .horizontal], .s14)
        .background(.ypLightGray, in: RoundedRectangle(cornerRadius: .s24))
    }

    private var divider: some View {
        Rectangle()
            .fill(.ypGray)
            .frame(height: Layout.dividerHeight)
    }
}

struct CarrierLogoView: View {
    let carrier: Carrier

    var body: some View {
        Group {
            if UIImage(named: carrier.logo) != nil {
                Image(carrier.logo)
                    .resizable()
                    .scaledToFit()
            } else {
                Text(carrier.title.prefix(1))
                    .font(.ypBold17)
                    .foregroundStyle(.ypBlackUniversal)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ypWhiteUniversal)
            }
        }
        .frame(width: Layout.logoSize, height: Layout.logoSize)
        .clipShape(RoundedRectangle(cornerRadius: .s12))
    }
}

private enum Layout {
    static let dividerHeight: CGFloat = 1
    static let logoSize: CGFloat = 38
}

#Preview {
    VStack(spacing: .s8) {
        TripCardView(trip: MockData.trips[0])
        TripCardView(trip: MockData.trips[1])
    }
    .padding()
}
