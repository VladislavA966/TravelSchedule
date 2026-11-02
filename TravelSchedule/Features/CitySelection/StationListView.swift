import SwiftUI

struct StationListView: View {
    let onSelect: (Station) -> Void
    @State private var viewModel: StationListViewModel
    @Environment(\.dismiss) private var dismiss

    init(city: City, onSelect: @escaping (Station) -> Void) {
        self.onSelect = onSelect
        _viewModel = State(initialValue: StationListViewModel(city: city))
    }

    var body: some View {
        SearchableList(
            items: viewModel.filteredStations,
            itemTitle: \.title,
            searchText: $viewModel.searchText,
            isLoading: false,
            emptyText: .stationSelectionEmpty,
            onSelect: onSelect
        )
        .navigationBar(title: .stationSelectionTitle) {
            dismiss()
        }
    }
}
