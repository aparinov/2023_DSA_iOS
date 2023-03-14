//
//  ProjectDetailsSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 05.03.2023.
//

import Foundation
import UIKit

enum ProjectDetailsSceneAssembly {
    static func build() -> ProjectDetailsViewController {
        let viewModel =  ProjectDetailsViewModel()
        let view = ProjectDetailsViewController(viewModel: viewModel)
        return view
    }
}
