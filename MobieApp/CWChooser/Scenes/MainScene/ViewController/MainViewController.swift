//
//  MainViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 19.02.2023.
//

import Foundation
import Combine
import UIKit

final class MainViewController: UIViewController {
    private let viewModel: MainViewModelProtocol?
    private var projectsList: [Project] = .init()
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "hseBackground")
        tableView.separatorColor = .systemGray
        tableView.register(ProjectThemeViewCell.self, forCellReuseIdentifier: "project")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        return tableView
    }()
    
    private let segmentControl: UISegmentedControl = {
        let values = ["Все", "Рекомендованные", "Запись"]
        let control = UISegmentedControl(items: values)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavBar()
        bind()
        viewModel?.viewActions.lifecycle.send(.didLoad)
    }
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.barTintColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTapped))
        setupNavBar()
    }
    
    init(viewModel: MainViewModelProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        projectsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "project") as! ProjectThemeViewCell
        let index = indexPath.row
        cell.configureCell(numberCell: index+1, model: projectsList[index])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else { return }
        let project = (tableView.cellForRow(at: indexPath) as! ProjectThemeViewCell).projectModel
        viewModel?.viewActions.tapOnProjectCellSubject.send((project, navigationController))
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

private extension MainViewController {
    func bind() {
        viewModel?.data.projectsSendPublisher
            .sink { [weak self] projects in
                self?.projectsList = projects
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &subscriptions)
    }
    
    func setupNavBar() {
        title = "Проекты"
    }
    
    @objc
    func addTapped() {
        guard let navController = navigationController else { return }
        viewModel?.viewActions.tapOnAddButtonSubject.send(navController)
    }
    
    func setupLayout() {
        view.backgroundColor = UIColor(named: "hseBackground")
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
