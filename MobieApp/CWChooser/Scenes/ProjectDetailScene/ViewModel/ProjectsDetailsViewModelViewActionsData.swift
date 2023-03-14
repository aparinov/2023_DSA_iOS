//
//  ProjectsDetailsViewModelViewActionsData.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 05.03.2023.
//

import Foundation
import Combine

protocol ProjectsDetailsViewModelViewActionsData {
    var viewActions: ProjectDetailsViewModelViewActions { get }
    
    var data: ProjectDetailsViewModelData { get }
}

struct ProjectDetailsViewModelViewActions {
    let lifeCycleSubject = PassthroughSubject<Lifecycle, Never>()
}

struct ProjectDetailsViewModelData {
    let headerDataPublisher = PassthroughSubject<HeaderDataModel, Never>()
}
