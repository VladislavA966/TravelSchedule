import Foundation

nonisolated struct Carrier: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let logo: String
    var largeLogo: String? = nil
    let email: String
    let phone: String
}
