import Foundation

nonisolated struct City: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let stations: [Station]
}
