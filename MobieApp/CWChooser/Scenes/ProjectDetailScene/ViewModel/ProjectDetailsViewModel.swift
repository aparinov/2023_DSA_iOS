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
    private let setEntryStyleSubject = PassthroughSubject<AcceptButtonViewCell.Style, Never>()
    private let setCancelStyleSubject = PassthroughSubject<AcceptButtonViewCell.Style, Never>()
    private var subscription = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    private let projectData: Project
    
    init(project: Project, networkService: NetworkServiceProtocol) {
        self.input = .init()
        self.output = .init()
        self.viewActions = .init(
            setEntryStylePublisher: setEntryStyleSubject.eraseToAnyPublisher(),
            setCancelStylePublisher: setCancelStyleSubject.eraseToAnyPublisher()
        )
        self.data = .init()
        self.projectData = project
        self.networkService = networkService
        bind()
    }
    
    func bind() {
        viewActions.lifeCycleSubject.sink { [weak self] lifecycle in
            guard let self = self else { return }
            switch lifecycle {
            case .didLoad:
                self.networkService.getAllRequirements(projectId: self.projectData.id) { result in
                    switch result {
                    case .success(let tags):
                        let resultStringTags = self.getTagsString(tags: tags)
                        let projectInfo = ProjectData(tags: resultStringTags, projectInfo: self.projectData)
                        self.data.projectDataSubject.send(projectInfo)
                    case .failure(let error):
                        print(error)
                    }
                }
                self.sendHeaderData()
            default: break
            }
        }.store(in: &subscription)
        
        viewActions.tapOnAcceptButton
            .sink { [weak self] projectId in
                let model = EntryOnProjectModel(student_id: 18, project_id: projectId)
                self?.networkService.entryOnProject(with: model) { result in
                    switch result {
                    case .success(_):
                        self?.setCancelStyleSubject.send(.cancelEntry)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            .store(in: &subscription)
        
        viewActions.cancelTapButtonSubject
            .sink { [weak self] projectId in
                self?.networkService.cancelEntryOnProject(
                    with: projectId,
                    status: "заявка отменена",
                    handler: { result in
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(_):
                            self?.setEntryStyleSubject.send(.entryOnProject)
                        }
                })
            }
            .store(in: &subscription)
    }
}

private extension ProjectDetailsViewModel {
    func sendHeaderData() {
        let header = HeaderDataModel(
            type: projectData.project_type,
            title: projectData.title,
            subtitle: projectData.supervisor,
            image: nil
        )
        data.headerDataPublisher.send(header)
    }
    
    func getTagsString(tags: [Tag]) -> String {
        var result = ""
        for item in tags {
            if tags.last?.name == item.name {
                result += item.name
            } else {
                result += item.name + ", "
            }
        }
        return result
    }
}

