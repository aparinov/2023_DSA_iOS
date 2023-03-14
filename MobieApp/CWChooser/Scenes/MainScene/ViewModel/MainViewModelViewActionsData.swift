//
//  MainViewModelViewActionsData.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 19.02.2023.
//

import Foundation
import Combine
import UIKit

protocol MainViewModelViewActionsData {
    var viewActions: MainViewModelActions { get }
    var data: MainViewModelData { get }
}

struct MainViewModelActions {
    let tapOnProjectCellSubject = PassthroughSubject<UINavigationController, Never>()
    
    let tapOnAddButtonSubject = PassthroughSubject<UINavigationController, Never>()
}

struct MainViewModelData {}
