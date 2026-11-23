import Combine
import Foundation

@MainActor
final class CarrierDetailsViewModel: ObservableObject {
    let carrier: Carrier

    init(carrier: Carrier) {
        self.carrier = carrier
    }

    var emailURL: URL? {
        guard !carrier.email.isEmpty else { return nil }
        return URL(string: "mailto:\(carrier.email)")
    }

    var phoneURL: URL? {
        guard !carrier.phone.isEmpty else { return nil }
        return URL(string: "tel:\(carrier.phone.filter { $0.isNumber || $0 == "+" })")
    }
}
