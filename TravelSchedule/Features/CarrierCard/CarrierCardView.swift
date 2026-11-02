import SwiftUI

struct CarrierCardView: View {
    let carrier: Carrier
    @Environment(Router<ScheduleRoute>.self) private var router

    var body: some View {
        Text(.carrierCardTitle)
            .font(.ypBold24)
            .foregroundStyle(.ypBlack)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ypWhite)
            .navigationBar(title: .carrierCardTitle, onBack: router.pop)
    }
}
