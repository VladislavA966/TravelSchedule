import SwiftUI

extension View {
    func navigationBar(title: LocalizedStringResource? = nil, onBack: @escaping () -> Void) -> some View {
        self
            .navigationTitle(title.map { Text($0) } ?? Text(verbatim: ""))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.ypSemibold17)
                            .foregroundStyle(.ypBlack)
                    }
                }
            }
    }
}
