import Foundation

struct Carrier: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let logoURL: URL?
    let email: String
    let phone: String
}
