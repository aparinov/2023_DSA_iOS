//
//  MainViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 19.02.2023.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    private let viewModel: MainViewModelProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "hseBackground")
        tableView.separatorColor = .systemGray
        tableView.register(ProjectThemeViewCell.self, forCellReuseIdentifier: "project")
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavBar()
    }
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
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
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "project") as! ProjectThemeViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        viewModel?.viewActions.tapOnProjectCellSubject.send(navController)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
}

private extension MainViewController {
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
