import SwiftUI

struct CityListView: View {
    let onSelect: (City) -> Void
    @State private var viewModel = CityListViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        SearchableList(
            items: viewModel.filteredCities,
            itemTitle: \.title,
            searchText: $viewModel.searchText,
            isLoading: viewModel.isLoading,
            emptyText: .citySelectionEmpty,
            onSelect: onSelect
        )
        .navigationBar(title: .citySelectionTitle) {
            dismiss()
        }
        .errorState(viewModel.error)
        .task {
            await viewModel.load()
        }
    }
}
