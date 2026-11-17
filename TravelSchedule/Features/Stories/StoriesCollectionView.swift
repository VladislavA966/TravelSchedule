import SwiftUI

struct StoriesCollectionView: View {
    let stories: [Story]
    let isViewed: (Story) -> Bool
    let onSelect: (Story) -> Void

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: .s12) {
                ForEach(stories) { story in
                    Button {
                        onSelect(story)
                    } label: {
                        StoryPreviewView(story: story, isViewed: isViewed(story))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, .s16)
            .padding(.vertical, .s24)
        }
        .scrollIndicators(.hidden)
        .frame(height: LayoutConstants.collectionHeight)
    }
}

private struct StoryPreviewView: View {
    let story: Story
    let isViewed: Bool

    var body: some View {
        Image(story.preview)
            .resizable()
            .scaledToFill()
            .frame(width: LayoutConstants.previewWidth, height: LayoutConstants.previewHeight)
            .overlay(alignment: .bottomLeading) {
                Text(story.title)
                    .font(.ypRegular12)
                    .foregroundStyle(.ypWhiteUniversal)
                    .lineLimit(LayoutConstants.titleLineLimit)
                    .padding(.horizontal, .s8)
                    .padding(.bottom, .s12)
            }
            .clipShape(RoundedRectangle(cornerRadius: .s16))
            .overlay {
                if !isViewed {
                    RoundedRectangle(cornerRadius: .s16)
                        .strokeBorder(.ypBlue, lineWidth: LayoutConstants.borderWidth)
                }
            }
            .opacity(isViewed ? LayoutConstants.viewedOpacity : 1)
            .animation(.default, value: isViewed)
    }
}

private enum LayoutConstants {
    static let previewWidth: CGFloat = 92
    static let previewHeight: CGFloat = 140
    static let collectionHeight: CGFloat = 188
    static let borderWidth: CGFloat = 4
    static let viewedOpacity = 0.5
    static let titleLineLimit = 3
}

#Preview {
    StoriesCollectionView(
        stories: MockData.stories,
        isViewed: { $0.id > 2 },
        onSelect: { _ in }
    )
}
