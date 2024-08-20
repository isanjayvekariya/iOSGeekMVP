//
//  UsersViewController.swift
//  iOSGeekMVP
//
//  Created by Sanjay Vekariya on 8/11/24.
//

import UIKit

protocol UsersViewControlling: AnyObject {
    func showUsers(_ users: [User])
    func showError(_ message: String)
}

final class UsersViewController: UIViewController {
    private var presenter: UsersPresenting
    private var users: [User] = []
    
    init(presenter: UsersPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.controller = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.screenTitle
        setupTableView()
        
        loadingIndicator.startAnimating()
        presenter.loadUsers()
    }
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: Constants.cellId)
        return tableView
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI Setup

private extension UsersViewController {
    func setupTableView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    struct Constants {
        static let screenTitle = "Users"
        static let cellId = "UserTableViewCell"
    }
}

// MARK: UsersViewControlling

extension UsersViewController: UsersViewControlling {
    func showUsers(_ users: [User]) {
        self.users = users
        tableView.reloadData()
        loadingIndicator.stopAnimating()
    }
    
    func showError(_ message: String) {
        loadingIndicator.stopAnimating()
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource & UITableViewDelegate

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let detailViewController = UserDetailViewController(user: user)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

