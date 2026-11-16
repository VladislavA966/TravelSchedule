import SwiftUI

enum ScheduleRoute: Hashable {
    case carriers(TripQuery)
    case filters
    case carrierCard(Carrier)
}

struct ScheduleFlowView: View {
    @State private var router = Router<ScheduleRoute>()
    @State private var filter = TripFilter()

    var body: some View {
        NavigationStack(path: $router.path) {
            MainView()
                .navigationDestination(for: ScheduleRoute.self) { route in
                    destination(for: route)
                        .toolbar(.hidden, for: .tabBar)
                }
        }
        .errorState()
        .environment(router)
        .onChange(of: router.path.isEmpty) { _, isEmpty in
            if isEmpty {
                filter = TripFilter()
            }
        }
    }

    @ViewBuilder
    private func destination(for route: ScheduleRoute) -> some View {
        switch route {
        case .carriers(let query):
            CarriersView(query: query, filter: $filter)
        case .filters:
            FiltersView(filter: $filter)
        case .carrierCard(let carrier):
            CarrierCardView(carrier: carrier)
        }
    }
}
