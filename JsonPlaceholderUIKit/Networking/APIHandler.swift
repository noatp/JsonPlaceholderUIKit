//
//  APIHandler.swift
//  JsonPlaceholderUIKit
//
//  Created by Toan Pham on 6/20/22.
//

import Foundation

struct APIHandler {
    static let shared: APIHandler = .init()
    
    private init(){}
    
    func getData(completion: @escaping (Result<[User], Error>) -> Void){
        guard let url = URL(string: Constant.apiUrlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("\(#fileID) \(#function): \(error)")
                completion(.failure(APIHandlerError.fetchError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("\(#fileID) \(#function): \(response.debugDescription)")
                completion(.failure(APIHandlerError.httpError))
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: data)
                    completion(.success(users))
                }
                catch {
                    print("\(#fileID) \(#function): \(error)")
                    completion(.failure(APIHandlerError.decodeError))
                }
            }
        }
        .resume()
    }
}

enum APIHandlerError: Error {
    case fetchError
    case httpError
    case decodeError
}
