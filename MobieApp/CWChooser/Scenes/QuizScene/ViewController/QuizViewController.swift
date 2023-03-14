//
//  QuizViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.02.2023.
//

import Foundation
import UIKit
import Combine

final class QuizViewController: UIViewController {
    
    private let viewModel: QuizViewModelProtocol?
    private var interestsArray: [String] = .init()
    var rowWhichAreChecked = [NSIndexPath]()
    private var subscription = Set<AnyCancellable>()
   
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(QuizCheckBoxCell.self, forCellReuseIdentifier: "quiz")
        tableView.register(AcceptButtonViewCell.self, forCellReuseIdentifier: "accept")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind()
        viewModel?.viewActions.lifeCycleSubject.send(.didLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    init(viewModel: QuizViewModelProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: TableView
extension QuizViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interestsArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < interestsArray.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "quiz", for: indexPath) as! QuizCheckBoxCell 
            cell.configureItem(title: interestsArray[indexPath.row])
            cell.backgroundColor = UIColor(named: "hseBackground")
            cell.selectionStyle = .none
            let isRowChecked = rowWhichAreChecked.contains(indexPath as NSIndexPath)
            cell.checkBoxButton.isChecked = isRowChecked
            cell.checkBoxButton.buttonClicked(sender: cell.checkBoxButton)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "accept") as! AcceptButtonViewCell
            cell.setSubject(subject: viewModel?.viewActions.showMainPageSubject)
            cell.backgroundColor = UIColor(named: "hseBackground")
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! QuizCheckBoxCell
        let isRowChecked = rowWhichAreChecked.contains(indexPath as NSIndexPath)
        if isRowChecked == false {
            cell.checkBoxButton.isChecked = true
            cell.checkBoxButton.buttonClicked(sender: cell.checkBoxButton)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! QuizCheckBoxCell
        cell.checkBoxButton.isChecked = false
        cell.checkBoxButton.buttonClicked(sender: cell.checkBoxButton)
        if let checkedItemIndex = rowWhichAreChecked.firstIndex(of: indexPath as NSIndexPath) {
            rowWhichAreChecked.remove(at: checkedItemIndex)
        }
    }
}

private extension QuizViewController {
    func setupLayout() {
        view.backgroundColor = UIColor(named: "hseBackground")
        tableView.backgroundColor = UIColor(named: "hseBackground")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavBar() {
        title = Localization.QuizViewController.navBarTitle
    }
    
    func bind() {
        viewModel?.data.quizArraySubject.sink(receiveValue: { [weak self] interests in
            self?.interestsArray = interests
        }).store(in: &subscription)
    }
}
