//
//  MainSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 24.02.2023.
//

import Foundation
import UIKit

enum MainSceneAssembly {
    static func build(navigationController: UINavigationController) -> MainViewController {
        let viewModel =  MainViewModel(navController: navigationController)
        let view = MainViewController(viewModel: viewModel)
        return view
    }
}
