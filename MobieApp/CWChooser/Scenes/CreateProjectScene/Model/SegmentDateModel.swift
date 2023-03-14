//
//  SegmentDateModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 13.03.2023.
//

import Foundation

struct SegmentDateModel {
    enum TypeProject: String {
        case research = "Исследовательская"
        case praktic = "Практическая"
    }
    
    let projectType: String
    
    let submissionDate: Date
    
    let applicationDate: Date
}
