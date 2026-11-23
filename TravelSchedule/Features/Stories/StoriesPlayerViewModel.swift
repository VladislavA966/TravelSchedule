import Combine
import Foundation

@MainActor
@Observable
final class StoriesPlayerViewModel {
    let stories: [Story]
    var currentStoryIndex: Int {
        didSet {
            guard oldValue != currentStoryIndex else { return }
            currentPageIndex = 0
            progress = 0
            onStoryShown(currentStory)
        }
    }
    private(set) var currentPageIndex = 0
    private(set) var progress: Double = 0
    private(set) var isFinished = false

    @ObservationIgnored private let onStoryShown: (Story) -> Void
    @ObservationIgnored private var timer: AnyCancellable?

    init(stories: [Story], initialStory: Story, onStoryShown: @escaping (Story) -> Void) {
        self.stories = stories
        self.currentStoryIndex = stories.firstIndex(of: initialStory) ?? 0
        self.onStoryShown = onStoryShown
    }

    func start() {
        onStoryShown(currentStory)
        startTimer()
    }

    var currentStory: Story {
        stories[currentStoryIndex]
    }

    func page(for story: Story) -> StoryPage {
        let index = story == currentStory ? currentPageIndex : 0
        return story.pages[index]
    }

    func progress(forPage index: Int, of story: Story) -> Double {
        guard story == currentStory else { return 0 }
        if index < currentPageIndex { return 1 }
        if index == currentPageIndex { return progress }
        return 0
    }

    func startTimer() {
        timer = Timer.publish(every: Constants.tick, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }

    func stopTimer() {
        timer = nil
    }

    func nextPage() {
        if currentPageIndex < currentStory.pages.count - 1 {
            currentPageIndex += 1
            progress = 0
        } else {
            nextStory()
        }
    }

    func previousPage() {
        if currentPageIndex > 0 {
            currentPageIndex -= 1
            progress = 0
        } else if currentStoryIndex > 0 {
            currentStoryIndex -= 1
        } else {
            progress = 0
        }
    }

    private func nextStory() {
        if currentStoryIndex < stories.count - 1 {
            currentStoryIndex += 1
        } else {
            stopTimer()
            isFinished = true
        }
    }

    private func tick() {
        progress += Constants.tick / Constants.pageDuration
        if progress >= 1 {
            nextPage()
        }
    }
}

private enum Constants {
    static let pageDuration: TimeInterval = 10
    static let tick: TimeInterval = 0.05
}
