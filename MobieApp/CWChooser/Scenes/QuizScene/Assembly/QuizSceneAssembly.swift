//
//  QuizSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 24.02.2023.
//

import Foundation
import UIKit

enum QuizSceneAssembly {
    static func build(navigationController: UINavigationController) -> QuizViewController {
        let viewModel =  QuizViewModel(navController: navigationController)
        let view = QuizViewController(viewModel: viewModel)
        return view
    }
}
