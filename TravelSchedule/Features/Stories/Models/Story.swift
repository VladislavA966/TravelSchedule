import Foundation

struct Story: Identifiable, Hashable, Sendable {
    let id: Int
    let preview: String
    let pages: [StoryPage]

    var title: String {
        pages.first?.title ?? ""
    }
}

struct StoryPage: Identifiable, Hashable, Sendable {
    let id: Int
    let image: String
    let title: String
    let text: String
}
