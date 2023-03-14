//
//  QuizViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.02.2023.
//

import Foundation
import Combine
import UIKit

typealias QuizViewModelProtocol = QuizViewModelInputOutput & QuizViewModelViewActionData

final class QuizViewModel: QuizViewModelProtocol {
    var input: QuizViewModelInput
    
    var output: QuizViewModelOutput
    
    var data: QuizViewModelData
    
    var viewActions: QuizViewModelViewActions
    
    private var subscription = Set<AnyCancellable>()
    
    private let navController: UINavigationController
    
    private let interests = ["Математика", "Мобильная разработка", "ML", "Backend", "Большие данные", "Аналитика", "Дизайн", "Frontend"]
    
    init(navController: UINavigationController) {
        self.input = .init()
        self.output = .init()
        self.data = .init()
        self.viewActions = .init()
        self.navController = navController
        bind()
    }
    
    func bind() {
        viewActions.lifeCycleSubject.sink { [weak self] lifecycle in
            guard let self = self else { return }
            switch lifecycle {
            case .didLoad:
                self.data.quizArraySubject.send(self.interests)
            default: break
            }
        }.store(in: &subscription)
        
        viewActions.showMainPageSubject.sink { [weak self] _ in
            guard let self = self else { return }
            let tabBar = UITabBarController()
            let appDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            
            let mainVC = MainSceneAssembly.build(navigationController: self.navController)
            let mainVCNC = UINavigationController(rootViewController: mainVC)
            
            let profileVC = ProfileSceneAssembly.build()
            let profileVCNC = UINavigationController(rootViewController: profileVC)
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
            appearance.backgroundColor = UIColor(named: "hseNavBar")
            
            mainVCNC.navigationBar.standardAppearance = appearance;
            mainVCNC.navigationBar.scrollEdgeAppearance = mainVCNC.navigationBar.standardAppearance
            
            profileVCNC.navigationBar.standardAppearance = appearance;
            profileVCNC.navigationBar.scrollEdgeAppearance = profileVCNC.navigationBar.standardAppearance
            
            tabBar.viewControllers = [mainVCNC, profileVCNC]
            appDelegate?.setRootViewController(tabBar)
        }.store(in: &subscription)
    }
}
