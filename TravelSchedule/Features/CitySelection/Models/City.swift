import Foundation

struct City: Identifiable, Hashable {
    let id: String
    let title: String
    let stations: [Station]
}
