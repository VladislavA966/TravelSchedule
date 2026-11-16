import Foundation

struct Trip: Identifiable, Hashable {
    let id: String
    let carrier: Carrier
    let date: String
    let departureTime: String
    let arrivalTime: String
    let duration: String
    let transferCity: String?

    var departureHour: Int {
        Int(departureTime.prefix(2)) ?? 0
    }
}
