//
//  ViewController.swift
//  JsonPlaceholderUIKit
//
//  Created by Toan Pham on 6/20/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let uiac: (String) -> UIAlertController = { message in
        let controller: UIAlertController = .init(title: "", message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .cancel)
        controller.addAction(dismiss)
        return controller
    }
    
    private let homeViewModel: HomeViewModel = .init()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // set up view
        setUpView()
        homeViewModel.getData { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.tableView.reloadData()
                }
                else {
                    guard let error = self?.homeViewModel.getError(),
                          let uiac = self?.uiac(error.localizedDescription)
                    else {
                        return
                    }
                    self?.present(uiac, animated: true)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        //table view
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let user = homeViewModel.userAt(row: indexPath.row)
        let textToDisplay = "Name: \(user.name ?? "")\nId: \(user.id ?? -1)\nUsername: \(user.username ?? "")"
        content.text = textToDisplay
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.usersCount()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = homeViewModel.userAt(row: indexPath.row)
        let detailVC = DetailViewController()
        detailVC.user = user
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

