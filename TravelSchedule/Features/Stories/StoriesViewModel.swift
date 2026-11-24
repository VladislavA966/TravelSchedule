import Combine
import Foundation

@MainActor
final class StoriesViewModel: ObservableObject {
    let stories: [Story]
    @Published private(set) var viewedIDs: Set<Story.ID> = []

    init(stories: [Story] = MockData.stories) {
        self.stories = stories
    }

    func isViewed(_ story: Story) -> Bool {
        viewedIDs.contains(story.id)
    }

    func markViewed(_ story: Story) {
        viewedIDs.insert(story.id)
    }
}
