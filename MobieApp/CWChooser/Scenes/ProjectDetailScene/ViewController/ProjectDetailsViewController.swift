//
//  ProjectDetailsViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 05.03.2023.
//

import Foundation
import UIKit
import Combine

final class ProjectDetailsViewController: UIViewController {
    
    private var viewModel: ProjectDetailsViewModelProtocol?
    
    private let headerView: ProfileHeaderView = {
        let header = ProfileHeaderView()
        header.backgroundColor = UIColor(named: "hseBackground")
        header.layer.cornerRadius = 12
        header.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .singleLine
        table.separatorColor = .systemGray
        table.isScrollEnabled = false
        table.register(ProfileInfoViewCell.self, forCellReuseIdentifier: "infoCell")
        table.register(AcceptButtonViewCell.self, forCellReuseIdentifier: "acceptCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let acceptButton: AcceptButtonView = {
        let button = AcceptButtonView()
        button.configureCell(title: "Запись на проект")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind()
        viewModel?.viewActions.lifeCycleSubject.send(.didLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Проект"
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    init(viewModel: ProjectDetailsViewModelProtocol?) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let techStackCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
           indexPath.row == 1 {
            techStackCell.configureItem(title: "Необходимые навыки", subTitle: "Swift, ООП, MLKit, UIKit, SwiftUI")
            return techStackCell
        } else if let documentDeadlineCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 2 {
            documentDeadlineCell.configureItem(title: "Крайник срок заявки", subTitle: "28.10.2023")
            return documentDeadlineCell
        } else if let deadlineProjectCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 3 {
            deadlineProjectCell.configureItem(title: "Дедлайн работы", subTitle: "28.05.2024")
            return deadlineProjectCell
        } else if let typeOfProject = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 0 {
            typeOfProject.configureItem(title: "Тип работы", subTitle: "Командная")
            return typeOfProject
        } else if let membersList = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 4 {
            membersList.configureItem(title: "Участники", subTitle: "Поволоцкий Виктор, Зубарева Наталья, Мостаченка Андрей, Сальникова Алиса")
            return membersList
        } else {
            let refOnProject = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! ProfileInfoViewCell
            refOnProject.configureItem(title: "Ссылка для официальной записи", subTitle: "google.docx/piupiupiupiu")
            return refOnProject
        }
    }
}

private extension ProjectDetailsViewController {
    
    func bind() {
        viewModel?.data.headerDataPublisher.sink(receiveValue: { [weak self] headerData in
            self?.headerView.setupHeader(type: headerData.type, title: headerData.title, subtitle: headerData.subtitle, image: headerData.image)
        }).store(in: &subscriptions)
    }
    
    func setupLayout() {
        view.backgroundColor = .black
        tableView.backgroundColor = UIColor(named: "hseBackground")
        
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(acceptButton)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            acceptButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            acceptButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            acceptButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            acceptButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
