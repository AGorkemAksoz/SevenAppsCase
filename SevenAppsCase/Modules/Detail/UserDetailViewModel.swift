//
//  UserDetailViewModel.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import Foundation

protocol UserDetailViewModelInterface {
    var user: User { get }
}

// MARK: - User Detail ViewModel
final class UserDetailViewModel: UserDetailViewModelInterface {
    let user: User
    
    init(user: User) {
        self.user = user
    }
}
