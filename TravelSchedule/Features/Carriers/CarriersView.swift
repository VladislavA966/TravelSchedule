import SwiftUI

struct CarriersView: View {
    @Binding var filter: TripFilter
    @State private var viewModel: CarriersViewModel
    @Environment(Router<ScheduleRoute>.self) private var router

    init(query: TripQuery, filter: Binding<TripFilter>) {
        _filter = filter
        _viewModel = State(initialValue: CarriersViewModel(query: query))
    }

    var body: some View {
        let trips = viewModel.filteredTrips(by: filter)

        VStack(alignment: .leading, spacing: .s16) {
            Text(viewModel.title)
                .font(.ypBold24)
                .foregroundStyle(.ypBlack)
                .padding(.horizontal, .s16)

            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if trips.isEmpty {
                EmptyStateView(text: .carriersEmpty)
            } else {
                ScrollView {
                    LazyVStack(spacing: .s8) {
                        ForEach(trips) { trip in
                            Button {
                                router.push(.carrierCard(trip.carrier))
                            } label: {
                                TripCardView(trip: trip)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, .s16)
                    .padding(.bottom, Layout.listBottomInset)
                }
            }
        }
        .padding(.top, .s16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(alignment: .bottom) {
            PrimaryButton(title: .carriersFilterButton, showsIndicator: filter.isActive) {
                router.push(.filters)
            }
            .padding(.horizontal, .s16)
            .padding(.bottom, .s24)
        }
        .background(.ypWhite)
        .navigationBar(onBack: router.pop)
        .errorState(viewModel.error)
        .task {
            await viewModel.load()
        }
    }
}

private enum Layout {
    static let listBottomInset: CGFloat = 100
}

#Preview {
    let moscow = MockData.cities[0]
    let spb = MockData.cities[1]
    NavigationStack {
        CarriersView(
            query: TripQuery(
                from: RoutePoint(city: moscow, station: moscow.stations[2]),
                to: RoutePoint(city: spb, station: spb.stations[2])
            ),
            filter: .constant(TripFilter())
        )
    }
    .environment(Router<ScheduleRoute>())
    .environment(NetworkMonitor())
}
