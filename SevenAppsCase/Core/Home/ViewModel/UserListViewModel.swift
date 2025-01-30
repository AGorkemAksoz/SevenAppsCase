//
//  UserListViewModel.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import Foundation

protocol UserListViewModelInterface {
    var view: UserListViewInterface? { get set }
    
    func viewDidLoad()
    func fetchUsers() async
}


// MARK: - User List ViewModel
final class UserListViewModel {
    weak var view: UserListViewInterface?
    private let repository: UserRepositoryProtocol
    private(set) var users: [User] = []
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
}

extension UserListViewModel: UserListViewModelInterface {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureUserListTableView()
        Task { await fetchUsers() }
    }
    
    func fetchUsers() async {
        do {
            self.users = try await repository.getUsers()
            self.view?.reloadUserListTableView()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
