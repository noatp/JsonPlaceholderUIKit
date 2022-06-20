//
//  HomeViewModel.swift
//  JsonPlaceholderUIKit
//
//  Created by Toan Pham on 6/20/22.
//

import Foundation

class HomeViewModel {
    private var users: [User] = []
    private var error: Error?
    
    func getData(completion: @escaping (_ success: Bool) -> Void) {
        APIHandler.shared.getData { [weak self] result in
            switch result {
            case .failure(let error):
                self?.error = error
                completion(false)
            case .success(let users):
                self?.users = users
                completion(true)
            }
        }
    }
    
    func usersCount() -> Int {
        return users.count
    }
    
    func userAt(row index: Int) -> User {
        return users[index]
    }
    
    func getError() -> Error? {
        return error
    }
}
