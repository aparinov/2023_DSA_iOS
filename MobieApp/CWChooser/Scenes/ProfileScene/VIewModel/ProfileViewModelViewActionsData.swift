//
//  ProfileViewModelViewActionsData.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 25.02.2023.
//

import Foundation

protocol ProfileViewModelViewActionsData {
    var viewActions: ProfileViewModelViewActions { get }
    
    var data: ProfileViewModelData { get }
}

struct ProfileViewModelViewActions {}

struct ProfileViewModelData {}
