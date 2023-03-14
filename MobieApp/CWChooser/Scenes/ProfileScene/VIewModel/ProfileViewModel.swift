//
//  ProfileViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 25.02.2023.
//

import Foundation

typealias ProfileViewModelProtocol = ProfileViewModelInputOutput & ProfileViewModelViewActionsData

final class ProfileViewModel: ProfileViewModelProtocol {
    var input: ProfileViewModelInput
    
    var output: ProfileViewModelOutput
    
    var viewActions: ProfileViewModelViewActions
    
    var data: ProfileViewModelData
    
    init() {
        self.input = .init()
        self.output = .init()
        self.viewActions = .init()
        self.data = .init()
    }
}
