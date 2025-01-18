import UIKit

class UserDetailViewController: UIViewController {
    private let viewModel: UserDetailViewModel

    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneLabel = UILabel()
    private let websiteLabel = UILabel()

    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchUserDetails()
    }

    private func setupUI() {
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel, phoneLabel, websiteLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.user = { [weak self] user in
            self?.nameLabel.text = "Name: \(user?.name ?? "N/A")"
            self?.emailLabel.text = "Email: \(user?.email ?? "N/A")"
            self?.phoneLabel.text = "Phone: \(user?.phone ?? "N/A")"
            self?.websiteLabel.text = "Website: \(user?.website ?? "N/A")"
        }

        viewModel.error = { [weak self] errorMessage in
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}
