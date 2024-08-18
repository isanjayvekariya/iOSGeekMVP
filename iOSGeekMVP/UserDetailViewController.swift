//
//  UserDetailViewController.swift
//  iOSGeekMVP
//
//  Created by Sanjay Vekariya on 8/12/24.
//

import UIKit

class UserDetailViewController: UIViewController {
    private let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGroupedBackground
        setupViews()
        configure(with: user)
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        return view
    }()
    
    private lazy var initialsView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    private let initialsLabel = UILabel()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    private let emailLabel = UILabel()
    private let phoneLabel = UILabel()
    private let addressLabel = UILabel()
    private let websiteLabel = UILabel()
    private let companyLabel = UILabel()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI Setup

private extension UserDetailViewController {
    func setupViews() {
        view.addSubview(scrollView)
    
        initialsView.addSubview(initialsLabel)
        initialsLabel.translatesAutoresizingMaskIntoConstraints = false
        initialsLabel.centerXAnchor.constraint(equalTo: initialsView.centerXAnchor).isActive = true
        initialsLabel.centerYAnchor.constraint(equalTo: initialsView.centerYAnchor).isActive = true
        initialsLabel.textColor = .white
        initialsLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)

        let headerStack = UIStackView(arrangedSubviews: [initialsView, nameLabel, usernameLabel])
        headerStack.axis = .vertical
        headerStack.spacing = 4
        headerStack.alignment = .center
        
        stackView.addArrangedSubview(headerStack)
        
        setupSection(title: "Email", contentLabel: emailLabel)
        setupSection(title: "Phone", contentLabel: phoneLabel)
        setupSection(title: "Address", contentLabel: addressLabel)
        setupSection(contentLabel: websiteLabel)
        setupSection(contentLabel: companyLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func setupSection(title: String? = nil, contentLabel: UILabel) {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 15)
        
        let sectionStack = UIStackView()
        sectionStack.axis = .vertical
        sectionStack.spacing = 5
        sectionStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sectionStack)
        
        if let title {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            titleLabel.text = title
            titleLabel.textColor = .darkGray
            sectionStack.addArrangedSubview(titleLabel)
        }
        
        contentLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 0
        sectionStack.addArrangedSubview(contentLabel)
        
        stackView.addArrangedSubview(view)
        
        // Add space above and below the card
        view.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        NSLayoutConstraint.activate([
            sectionStack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            sectionStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            sectionStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            sectionStack.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func configure(with user: User) {
        initialsLabel.text = user.name.abbreviation
        nameLabel.text = user.name
        usernameLabel.text = "@\(user.username)"
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        addressLabel.text = "\(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode)"
        websiteLabel.text = "Website: \(user.website)"
        companyLabel.text = "Company: \(user.company.name)\n\(user.company.catchPhrase)\n\(user.company.bs)"
    }
}


