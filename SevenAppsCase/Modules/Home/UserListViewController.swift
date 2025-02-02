//
//  UserListViewController.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import UIKit

protocol UserListViewInterface: AnyObject {
    func configureVC()
    func configureUserListTableView()
    func reloadUserListTableView()
    func configureActivityIndicator()
    func navigateToDetailScreen(user: User)
    func showLoadingIndicator(_ show: Bool)
    func showError(_ message: String)
}

// MARK: - User List ViewController
final class UserListViewController: UIViewController {
    private let viewModel: UserListViewModel
    
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
         let indicator = UIActivityIndicatorView(style: .large)
         indicator.hidesWhenStopped = true
         return indicator
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        configureVC()
        configureUserListTableView()
        configureActivityIndicator()
    }
}

extension UserListViewController: UserListViewInterface {
    func configureVC() {
        title = "Users"
    }
    
    func configureUserListTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        view.addSubview(tableView)
    }
    
    func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    func reloadUserListTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.showLoadingIndicator(false)
        }
    }
    
    func navigateToDetailScreen(user: User) {
        let detailVC = UserDetailViewController(user: user)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func showLoadingIndicator(_ show: Bool) {
        DispatchQueue.main.async {
            show ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Hata!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        self.navigateToDetailScreen(user: user)
    }
}
