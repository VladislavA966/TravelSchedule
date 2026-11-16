import SwiftUI

struct SearchableList<Item: Identifiable>: View {
    let items: [Item]
    let itemTitle: (Item) -> String
    @Binding var searchText: String
    let isLoading: Bool
    let emptyText: LocalizedStringResource
    let onSelect: (Item) -> Void

    var body: some View {
        VStack(spacing: .s16) {
            SearchBar(text: $searchText)
                .padding(.horizontal, .s16)

            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if items.isEmpty {
                EmptyStateView(text: emptyText)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(items) { item in
                            Button {
                                onSelect(item)
                            } label: {
                                ChevronRow(title: itemTitle(item))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, .s16)
                }
                .scrollDismissesKeyboard(.immediately)
            }
        }
        .padding(.top, .s8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.ypWhite)
    }
}
