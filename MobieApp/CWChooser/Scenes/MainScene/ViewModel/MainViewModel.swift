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
    
    init(navController: UINavigationController) {
        self.input = .init()
        self.output = .init()
        self.viewActions = .init()
        self.data = .init()
        self.navController = navController
        bind()
    }
}

private extension MainViewModel {
    func bind() {
        viewActions.tapOnProjectCellSubject.sink { navController in
            let view = ProjectDetailsSceneAssembly.build()
            navController.pushViewController(view, animated: true)
        }.store(in: &subscription)
        
        viewActions.tapOnAddButtonSubject.sink { navController in
            let view = MainCreateProjectsAssembly.build()
            navController.pushViewController(view, animated: true)
        }.store(in: &subscription)
    }
}


