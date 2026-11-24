import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @StateObject private var storiesViewModel = StoriesViewModel()
    @State private var selectedStory: Story?
    @Environment(Router<ScheduleRoute>.self) private var router

    var body: some View {
        VStack(spacing: .s20) {
            StoriesCollectionView(
                stories: storiesViewModel.stories,
                isViewed: storiesViewModel.isViewed,
                onSelect: { selectedStory = $0 }
            )

            directionSection

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ypWhite)
        .animation(.default, value: viewModel.canSearch)
        .fullScreenCover(item: $viewModel.activeField) { field in
            CitySelectionFlowView { point in
                viewModel.select(point, for: field)
            }
        }
        .fullScreenCover(item: $selectedStory) { story in
            StoriesPlayerView(
                viewModel: StoriesPlayerViewModel(
                    stories: storiesViewModel.stories,
                    initialStory: story,
                    onStoryShown: storiesViewModel.markViewed
                )
            )
        }
    }

    private var directionSection: some View {
        VStack(spacing: .s16) {
            DirectionPicker(
                from: viewModel.from?.title,
                to: viewModel.to?.title,
                onTapFrom: { viewModel.activeField = .from },
                onTapTo: { viewModel.activeField = .to },
                onSwap: {
                    withAnimation {
                        viewModel.swap()
                    }
                }
            )

            if let query = viewModel.query {
                PrimaryButton(title: .mainSearch) {
                    router.push(.carriers(query))
                }
                .frame(width: LayoutConstants.searchButtonWidth)
                .transition(.opacity)
            }
        }
        .padding(.horizontal, .s16)
    }
}

private struct DirectionPicker: View {
    let from: String?
    let to: String?
    let onTapFrom: () -> Void
    let onTapTo: () -> Void
    let onSwap: () -> Void

    var body: some View {
        HStack(spacing: .s16) {
            VStack(spacing: 0) {
                row(text: from, placeholder: .mainFrom, action: onTapFrom)
                row(text: to, placeholder: .mainTo, action: onTapTo)
            }
            .background(.ypWhiteUniversal, in: RoundedRectangle(cornerRadius: .s20))

            Button(action: onSwap) {
                Image(systemName: "arrow.2.squarepath")
                    .font(.ypSemibold17)
                    .foregroundStyle(.ypBlue)
                    .frame(width: .s36, height: .s36)
                    .background(.ypWhiteUniversal, in: Circle())
            }
        }
        .padding(.s16)
        .background(.ypBlue, in: RoundedRectangle(cornerRadius: .s20))
    }

    private func row(text: String?, placeholder: LocalizedStringResource, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            (text.map { Text(verbatim: $0) } ?? Text(placeholder))
                .font(.ypRegular17)
                .foregroundStyle(text == nil ? .ypGray : .ypBlackUniversal)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, .s16)
                .frame(height: .s48)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

private enum LayoutConstants {
    static let searchButtonWidth: CGFloat = 150
}

#Preview {
    NavigationStack {
        MainView()
    }
    .environment(Router<ScheduleRoute>())
    .environment(NetworkMonitor())
}
