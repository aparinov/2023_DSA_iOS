//
//  QuizViewModelViewActionData.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.02.2023.
//

import Foundation
import Combine
import UIKit

protocol QuizViewModelViewActionData {
    var data: QuizViewModelData { get }
    
    var viewActions: QuizViewModelViewActions { get }
}

struct QuizViewModelViewActions {
    let lifeCycleSubject = PassthroughSubject<Lifecycle, Never>()
    
    let showMainPageSubject = PassthroughSubject<Void, Never>()
}

struct QuizViewModelData {
    let quizArraySubject = PassthroughSubject<[String], Never>()
}
