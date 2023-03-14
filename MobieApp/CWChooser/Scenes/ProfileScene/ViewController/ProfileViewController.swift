//
//  ProfileViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 25.02.2023.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    
    private let viewModel: ProfileViewModel?
    
    private let headerView: ProfileHeaderView = {
        let headerView = ProfileHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.layer.cornerRadius = 12
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(ProfileInfoViewCell.self, forCellReuseIdentifier: "infoCell")
        table.separatorColor = .systemGray
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    init(viewModel: ProfileViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let aboutMeCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
           indexPath.row == 0 {
            aboutMeCell.configureItem(title: "О себе", subTitle: "Я люблю эпл и писать для него, помогите иначе я рано или поздно уеду в калифорнию и стану пить мартини на берегу океана")
            return aboutMeCell
        } else if let facultyCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 2 {
            facultyCell.configureItem(title: "Факультет", subTitle: "Факультет компьютерных наук")
            return facultyCell
        } else if let emailCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 3 {
            emailCell.configureItem(title: "Email-адрес", subTitle: "arteezycat@gmail.com")
            return emailCell
        } else if let interestCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 1 {
            interestCell.configureItem(title: "Интересы", subTitle: "Фронтенд, бэкенд, машинное обучение, дизайн, прочие интересные приколы")
            return interestCell
        } else {
            let telephoneNumberCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! ProfileInfoViewCell
            telephoneNumberCell.configureItem(title: "Номер телефона", subTitle: "+7-938-339-03-87")
            return telephoneNumberCell
        }
    }
}

private extension ProfileViewController {
    func setupNavBar() {
        title = "Профиль"
    }
    
    func setupLayout() {
        view.backgroundColor = .black
        tableView.backgroundColor = UIColor(named: "hseBackground")
        
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
