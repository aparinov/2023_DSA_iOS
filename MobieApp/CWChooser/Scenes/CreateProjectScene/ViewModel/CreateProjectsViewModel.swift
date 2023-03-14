//
//  CreateProjectsViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 08.03.2023.
//

import Foundation

typealias CreateProjectsViewModelProtocol = CreateProjectsViewModelViewActionsData & CreateProjectsViewModelInputOutput

final class CreateProjectsViewModel: CreateProjectsViewModelProtocol {
    var viewActions: CreateProjectsViewModelViewActions
    
    var data: CreateProjectsViewModelData
    
    var input: CreateProjectsViewModelInput
    
    var output: CreateProjectsViewModelOutput
    
    init() {
        self.viewActions = .init()
        self.data = .init()
        self.input = .init()
        self.output = .init()
    }
}
