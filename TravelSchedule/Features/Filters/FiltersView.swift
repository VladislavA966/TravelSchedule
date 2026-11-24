import SwiftUI

struct FiltersView: View {
    @Binding var filter: TripFilter
    @StateObject private var viewModel: FiltersViewModel
    @Environment(Router<ScheduleRoute>.self) private var router

    init(filter: Binding<TripFilter>) {
        _filter = filter
        _viewModel = StateObject(wrappedValue: FiltersViewModel(filter: filter.wrappedValue))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .s16) {
                Text(.filtersDepartureTime)
                    .font(.ypBold24)
                    .foregroundStyle(.ypBlack)

                VStack(spacing: 0) {
                    ForEach(DepartureTime.allCases, id: \.self) { time in
                        CheckboxRow(title: time.title, isOn: binding(for: time))
                    }
                }

                Text(.filtersTransfers)
                    .font(.ypBold24)
                    .foregroundStyle(.ypBlack)

                VStack(spacing: 0) {
                    RadioRow(title: .filtersYes, isSelected: viewModel.draft.showTransfers == true) {
                        viewModel.setShowTransfers(true)
                    }
                    RadioRow(title: .filtersNo, isSelected: viewModel.draft.showTransfers == false) {
                        viewModel.setShowTransfers(false)
                    }
                }
            }
            .padding(.horizontal, .s16)
            .padding(.top, .s16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            if viewModel.canApply {
                PrimaryButton(title: .filtersApply) {
                    filter = viewModel.draft
                    router.pop()
                }
                .padding(.horizontal, .s16)
                .padding(.bottom, .s24)
            }
        }
        .background(.ypWhite)
        .navigationBar(onBack: router.pop)
    }

    private func binding(for time: DepartureTime) -> Binding<Bool> {
        Binding(
            get: { viewModel.isSelected(time) },
            set: { viewModel.setSelected($0, for: time) }
        )
    }
}

#Preview {
    @Previewable @State var filter = TripFilter()
    NavigationStack {
        FiltersView(filter: $filter)
    }
    .environment(Router<ScheduleRoute>())
}
