import SwiftUI

struct FiltersView: View {
    @Binding var filter: TripFilter
    @State private var draft: TripFilter
    @Environment(Router<ScheduleRoute>.self) private var router

    init(filter: Binding<TripFilter>) {
        _filter = filter
        _draft = State(initialValue: filter.wrappedValue)
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
                    RadioRow(title: .filtersYes, isSelected: draft.showTransfers == true) {
                        draft.showTransfers = true
                    }
                    RadioRow(title: .filtersNo, isSelected: draft.showTransfers == false) {
                        draft.showTransfers = false
                    }
                }
            }
            .padding(.horizontal, .s16)
            .padding(.top, .s16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            if draft != filter {
                PrimaryButton(title: .filtersApply) {
                    filter = draft
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
            get: { draft.departureTimes.contains(time) },
            set: { isOn in
                if isOn {
                    draft.departureTimes.insert(time)
                } else {
                    draft.departureTimes.remove(time)
                }
            }
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
