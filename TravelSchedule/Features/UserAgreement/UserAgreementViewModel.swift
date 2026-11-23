import Combine
import Foundation

@MainActor
final class UserAgreementViewModel: ObservableObject {
    let url = Constants.agreementURL
    @Published var isLoading = true
    @Published var error: AppError?
}

private enum Constants {
    static let agreementURL = URL(string: "https://yandex.ru/legal/practicum_offer")!
}
