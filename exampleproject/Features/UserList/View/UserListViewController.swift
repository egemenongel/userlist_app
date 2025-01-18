import UIKit

class UserListViewController: UIViewController {
    private var viewModel: UserListViewModel!
    private var tableView: UITableView!

    init(viewModel: UserListViewModel) {
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
        viewModel.fetchUsers()
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "User List"

        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")

        view.addSubview(tableView)

        // Constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = viewModel.user(at: indexPath.row)
        cell.textLabel?.text = "\(user.name) - \(user.email)"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.user(at: indexPath.row)

        // Create a new UserDetailService
        let service = UserDetailService(repository: UserDetailRepository())

        // Create a new UserDetailViewModel with the selected user's ID
        let detailViewModel = UserDetailViewModel(service: service, userId: user.id)

        // Pass the UserDetailViewModel to UserDetailViewController
        let detailVC = UserDetailViewController(viewModel: detailViewModel)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
