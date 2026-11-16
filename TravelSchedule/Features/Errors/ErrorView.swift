import SwiftUI

struct ErrorView: View {
    let error: AppError

    var body: some View {
        VStack(spacing: .s16) {
            Image(error.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: Layout.illustrationSize, height: Layout.illustrationSize)
                .clipShape(RoundedRectangle(cornerRadius: Layout.illustrationRadius))
            Text(error.title)
                .font(.ypBold24)
                .foregroundStyle(.ypBlack)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ypWhite)
    }
}

extension View {
    func errorState(_ error: AppError? = nil) -> some View {
        modifier(ErrorStateModifier(error: error))
    }
}

private struct ErrorStateModifier: ViewModifier {
    let error: AppError?
    @Environment(NetworkMonitor.self) private var networkMonitor

    private var visibleError: AppError? {
        networkMonitor.isConnected ? error : .noInternet
    }

    func body(content: Content) -> some View {
        content.overlay {
            if let visibleError {
                ErrorView(error: visibleError)
            }
        }
    }
}

private enum Layout {
    static let illustrationSize: CGFloat = 223
    static let illustrationRadius: CGFloat = 70
}

#Preview("Ошибка сервера") {
    ErrorView(error: .server)
}

#Preview("Нет интернета") {
    ErrorView(error: .noInternet)
}
