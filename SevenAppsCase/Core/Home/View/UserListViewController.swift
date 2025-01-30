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
    func navigateToDetailScreen(user: User)
}

// MARK: - User List ViewController
final class UserListViewController: UIViewController {
    private var viewModel = UserListViewModel()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension UserListViewController: UserListViewInterface {
    func configureVC() {
        title = "Users"
    }
    
    func configureUserListTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    func reloadUserListTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func navigateToDetailScreen(user: User) {
        let detailVC = UserDetailViewController(user: user)
        navigationController?.pushViewController(detailVC, animated: true)
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
