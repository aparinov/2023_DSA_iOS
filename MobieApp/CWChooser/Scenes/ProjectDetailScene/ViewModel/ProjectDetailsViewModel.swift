//
//  ProjectDetailsViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 05.03.2023.
//

import Foundation
import Combine

typealias ProjectDetailsViewModelProtocol = ProjectDetailsViewModelInputOutput & ProjectsDetailsViewModelViewActionsData

final class ProjectDetailsViewModel: ProjectDetailsViewModelProtocol {
    var input: ProjectDetailsViewModelInput
    
    var output: ProjectDetailsViewModelOutput
    
    var viewActions: ProjectDetailsViewModelViewActions
    
    var data: ProjectDetailsViewModelData
    
//    private let headerDataSubject = PassthroughSubject<HeaderDataModel, Never>()
    private var subscription = Set<AnyCancellable>()
//    private let projectData: Project
    
    init() {
        self.input = .init()
        self.output = .init()
        self.viewActions = .init()
        self.data = .init()
        bind()
    }
    
    func bind() {
        viewActions.lifeCycleSubject.sink { [weak self] lifecycle in
            guard let self = self else { return }
            switch lifecycle {
            case .didLoad:
                self.sendHeaderData()
            default: break
            }
        }.store(in: &subscription)
    }
}

private extension ProjectDetailsViewModel {
    func sendHeaderData() {
        let header = HeaderDataModel(
            type: "ПРОЕКТ",
            title: "Моделирование алгоритмов и всяких других различных занимательных приколдесов, это будет довольно сложно, но тебе понравится",
            subtitle: "Паринов Андрец Андреич",
            image: nil
        )
        data.headerDataPublisher.send(header)
    }
}

