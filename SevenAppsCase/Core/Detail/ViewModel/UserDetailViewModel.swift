//
//  UserDetailViewModel.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import Foundation

protocol UserDetailViewModelInterface {
    var view: UserDetailViewControllerInterface? { get set }
    
    func viewDidLoad()
}

// MARK: - User Detail ViewModel
final class UserDetailViewModel {
    weak var view: UserDetailViewControllerInterface?
    let user: User
    init(user: User) {
        self.user = user
    }
}

extension UserDetailViewModel: UserDetailViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.setupTableView()
    }
    
    
}
