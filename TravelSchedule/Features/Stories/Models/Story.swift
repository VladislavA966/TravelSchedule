import Foundation

struct Story: Identifiable, Hashable {
    let id: Int
    let preview: String
    let pages: [StoryPage]

    var title: String {
        pages.first?.title ?? ""
    }
}

struct StoryPage: Identifiable, Hashable {
    let id: Int
    let image: String
    let title: String
    let text: String
}
