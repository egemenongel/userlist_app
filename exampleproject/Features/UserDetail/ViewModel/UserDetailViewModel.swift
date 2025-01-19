import Foundation

class UserDetailViewModel {
    private let service: UserDetailServiceProtocol
    private var userId: Int

    var user: ((User?) -> Void)?
    var error: ((String) -> Void)?

    init(service: UserDetailServiceProtocol, userId: Int) {
        self.service = service
        self.userId = userId
    }

    func fetchUserDetails() {
        service.fetchUserDetails(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.user?(users)
                case .failure(let error):
                    self?.error?(error.localizedDescription)
                }
            }
        }
    }
}
