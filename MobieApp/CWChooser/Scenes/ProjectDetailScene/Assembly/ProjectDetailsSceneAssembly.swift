//
//  ProjectDetailsSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 05.03.2023.
//

import Foundation
import UIKit

enum ProjectDetailsSceneAssembly {
    static func build(model: Project, networkService: NetworkServiceProtocol) -> ProjectDetailsViewController {
        let viewModel =  ProjectDetailsViewModel(project: model, networkService: networkService)
        let view = ProjectDetailsViewController(viewModel: viewModel)
        return view
    }
}
