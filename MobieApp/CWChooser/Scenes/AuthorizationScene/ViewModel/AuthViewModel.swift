//
//  AuthViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 11.02.2023.
//

import Foundation
import Combine
import UIKit

typealias AuthViewModelProtocol = AuthViewModelInputOutput & AuthViewModelViewActionsData

final class AuthViewModel: AuthViewModelProtocol {
    var input: AuthViewModelInput = .init()
    
    var output: AuthViewModelOutput
    
    var data: AuthViewModelData
    
    var viewActions: AuthViewModelViewActions
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let showQuizSubject = PassthroughSubject<UIViewController, Never>()
    
    private let navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.output = AuthViewModelOutput()
        self.viewActions = AuthViewModelViewActions(showQuizPublisher: showQuizSubject.eraseToAnyPublisher())
        self.data = AuthViewModelData()
        self.navController = navController
        self.bind()
    }
    
    func bind() {
        output.buttonTabSubject.sink { [weak self] model in
            let requestModel = AuthRequestModel(
                login: model.login,
                password: model.password
            )
            self?.loginOnELK(with: requestModel)
        }.store(in: &subscriptions)
    }
    
    func loginOnELK(with authModel: AuthRequestModel) {
        print("\(authModel.login) \(authModel.password)")
        let view = QuizSceneAssembly.build(navigationController: navController)
        navController.pushViewController(view, animated: true)
    }
}
