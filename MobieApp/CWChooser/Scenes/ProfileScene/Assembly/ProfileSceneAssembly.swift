//
//  ProfileSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 26.02.2023.
//

import Foundation

enum ProfileSceneAssembly {
    static func build() -> ProfileViewController {
        let viewModel = ProfileViewModel()
        let view = ProfileViewController(viewModel: viewModel)
        return view
    }
}
