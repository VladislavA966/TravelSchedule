import SwiftUI

struct StoriesPlayerView: View {
    @State private var viewModel: StoriesPlayerViewModel
    @State private var dragOffset: CGFloat = 0
    @Environment(\.dismiss) private var dismiss

    init(viewModel: StoriesPlayerViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        TabView(selection: $viewModel.currentStoryIndex) {
            ForEach(Array(viewModel.stories.enumerated()), id: \.element.id) { index, story in
                StoryPageView(
                    page: viewModel.page(for: story),
                    pagesCount: story.pages.count,
                    progress: { viewModel.progress(forPage: $0, of: story) },
                    onPrevious: { withAnimation { viewModel.previousPage() } },
                    onNext: { withAnimation { viewModel.nextPage() } },
                    onClose: { dismiss() }
                )
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background(.ypBlackUniversal)
        .offset(y: dragOffset)
        .scaleEffect(1 - dragOffset / LayoutConstants.dragScaleDivider)
        .simultaneousGesture(closeGesture)
        .preferredColorScheme(.dark)
        .onAppear(perform: viewModel.start)
        .onDisappear(perform: viewModel.stopTimer)
        .onChange(of: viewModel.isFinished) { _, isFinished in
            if isFinished {
                dismiss()
            }
        }
    }

    private var closeGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let translation = value.translation
                guard translation.height > 0, translation.height > abs(translation.width) else { return }
                viewModel.stopTimer()
                dragOffset = translation.height
            }
            .onEnded { _ in
                if dragOffset > LayoutConstants.dismissThreshold {
                    dismiss()
                } else {
                    withAnimation {
                        dragOffset = 0
                    }
                    viewModel.startTimer()
                }
            }
    }
}

private struct StoryPageView: View {
    let page: StoryPage
    let pagesCount: Int
    let progress: (Int) -> Double
    let onPrevious: () -> Void
    let onNext: () -> Void
    let onClose: () -> Void

    var body: some View {
        Color.clear
            .background {
                Image(page.image)
                    .resizable()
                    .scaledToFill()
            }
            .overlay {
                HStack(spacing: 0) {
                    tapArea(action: onPrevious)
                    tapArea(action: onNext)
                }
            }
            .overlay(alignment: .top) {
                StoryProgressBar(pagesCount: pagesCount, progress: progress)
                    .padding(.horizontal, .s12)
                    .padding(.top, LayoutConstants.progressTopInset)
            }
            .overlay(alignment: .topTrailing) {
                closeButton
                    .padding(.trailing, .s12)
                    .padding(.top, LayoutConstants.closeTopInset)
            }
            .overlay(alignment: .bottomLeading) {
                texts
            }
            .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
            .padding(.top, LayoutConstants.contentTopInset)
            .padding(.bottom, LayoutConstants.contentBottomInset)
    }

    private var texts: some View {
        VStack(alignment: .leading, spacing: .s16) {
            Text(page.title)
                .font(.ypBold34)
                .lineLimit(LayoutConstants.titleLineLimit)
            Text(page.text)
                .font(.ypRegular20)
                .lineLimit(LayoutConstants.textLineLimit)
        }
        .foregroundStyle(.ypWhiteUniversal)
        .padding(.horizontal, .s16)
        .padding(.bottom, LayoutConstants.textBottomInset)
        .allowsHitTesting(false)
    }

    private var closeButton: some View {
        Button(action: onClose) {
            Image(systemName: "xmark")
                .font(.system(size: LayoutConstants.closeIconSize, weight: .bold))
                .foregroundStyle(.ypWhiteUniversal)
                .frame(width: LayoutConstants.closeSize, height: LayoutConstants.closeSize)
                .background(.ypBlackUniversal, in: Circle())
        }
    }

    private func tapArea(action: @escaping () -> Void) -> some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture(perform: action)
    }
}

private struct StoryProgressBar: View {
    let pagesCount: Int
    let progress: (Int) -> Double

    var body: some View {
        HStack(spacing: LayoutConstants.progressSpacing) {
            ForEach(0..<pagesCount, id: \.self) { index in
                Capsule()
                    .fill(.ypWhiteUniversal)
                    .overlay(alignment: .leading) {
                        GeometryReader { proxy in
                            Capsule()
                                .fill(.ypBlue)
                                .frame(width: proxy.size.width * progress(index))
                        }
                    }
                    .clipShape(Capsule())
            }
        }
        .frame(height: LayoutConstants.progressHeight)
        .allowsHitTesting(false)
    }
}

private enum LayoutConstants {
    static let contentTopInset: CGFloat = 7
    static let contentBottomInset: CGFloat = 17
    static let cornerRadius: CGFloat = 40
    static let progressTopInset: CGFloat = 28
    static let progressHeight: CGFloat = 6
    static let progressSpacing: CGFloat = 6
    static let closeTopInset: CGFloat = 50
    static let closeSize: CGFloat = 30
    static let closeIconSize: CGFloat = 12
    static let textBottomInset: CGFloat = 40
    static let titleLineLimit = 2
    static let textLineLimit = 3
    static let dismissThreshold: CGFloat = 150
    static let dragScaleDivider: CGFloat = 3000
}

#Preview {
    StoriesPlayerView(
        viewModel: StoriesPlayerViewModel(
            stories: MockData.stories,
            initialStory: MockData.stories[0],
            onStoryShown: { _ in }
        )
    )
}
