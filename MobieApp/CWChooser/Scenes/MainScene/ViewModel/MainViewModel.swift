//
//  MainViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 19.02.2023.
//

import Foundation
import UIKit
import Combine

typealias MainViewModelProtocol = MainViewModelInputOutput & MainViewModelViewActionsData

final class MainViewModel: MainViewModelProtocol {
    var input: MainViewModelInput
    
    var output: MainViewModelOutput
    
    var viewActions: MainViewModelActions
    
    var data: MainViewModelData
    
    private let navController: UINavigationController
    private var subscription = Set<AnyCancellable>()
    private let projectSendSubject = PassthroughSubject<[Project], Never>()
    private let networkService: NetworkServiceProtocol
    private let user: UserModel
    
    init(navController: UINavigationController, networkService: NetworkServiceProtocol, user: UserModel) {
        self.input = .init()
        self.output = .init()
        self.viewActions = .init()
        self.data = .init(projectsSendPublisher: projectSendSubject.eraseToAnyPublisher())
        self.navController = navController
        self.networkService = networkService
        self.user = user
        bind()
    }
}

private extension MainViewModel {
    func bind() {
        viewActions.lifecycle.sink { [weak self] lifecycle in
            switch lifecycle {
            case.didLoad:
                self?.loadProjects()
            default:
                return
            }
        }.store(in: &subscription)
        
        viewActions.tapOnProjectCellSubject.sink { [weak self] project, navController in
            guard let self = self else { return }
            let view = ProjectDetailsSceneAssembly.build(model: project, networkService: self.networkService)
            navController.pushViewController(view, animated: true)
//            self?.projectService.getListURLSession(resultTask: ([ProjectService.Project]) -> Void)
        }.store(in: &subscription)
        
        viewActions.tapOnAddButtonSubject.sink { [weak self] navController in
            guard let self = self else { return }
            let view = MainCreateProjectsAssembly.build(networkService: self.networkService)
            navController.pushViewController(view, animated: true)
        }.store(in: &subscription)
        
    }
    
    func loadProjects() {
        networkService.getAllProjects { [weak self] result in
            switch result {
            case .success(let projects):
                self?.projectSendSubject.send(projects)
            case .failure(let error):
                print(error)
            }
        }
    }

}


