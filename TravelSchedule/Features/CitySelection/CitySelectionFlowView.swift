import SwiftUI

struct CitySelectionFlowView: View {
    let onSelect: (RoutePoint) -> Void
    @State private var path: [City] = []

    var body: some View {
        NavigationStack(path: $path) {
            CityListView { city in
                path.append(city)
            }
            .navigationDestination(for: City.self) { city in
                StationListView(city: city) { station in
                    onSelect(RoutePoint(city: city, station: station))
                }
            }
        }
        .errorState()
    }
}
