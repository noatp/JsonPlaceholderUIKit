//
//  DetailViewController.swift
//  JsonPlaceholderUIKit
//
//  Created by Toan Pham on 6/20/22.
//

import UIKit

class DetailViewController: UIViewController {
    var user: User? {
        didSet {
            nameLabel.text = "Name: \(user?.name ?? "")"
            idLabel.text = "Id: \(user?.id ?? -1)"
            usernameLabel.text = "Username: \(user?.username ?? "")"
        }
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        view.backgroundColor = .white
        title = "Detail"
        let subviews = [nameLabel, idLabel, usernameLabel]
        for subview in subviews {
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true

        
        idLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
}
