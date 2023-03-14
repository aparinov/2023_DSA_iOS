//
//  QuizCheckBoxCell.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.02.2023.
//

import Foundation
import UIKit

final class QuizCheckBoxCell: UITableViewCell {
    private let grid = Grid()
    
    let checkBoxButton: CheckBoxButton = {
        let button = CheckBoxButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureItem(title: String) {
        self.titleLabel.text = title
    }
}
 
private extension QuizCheckBoxCell {
    enum Constants {
        static let titleWidth: CGFloat = 200
        static let sideSize: CGFloat = 25
    }
    
    func setupLayout() {
        contentView.addSubview(checkBoxButton)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: grid.xlargeOffset),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: grid.xlargeOffset),
            titleLabel.widthAnchor.constraint(equalToConstant: Constants.titleWidth),
            
            checkBoxButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -grid.xlargeOffset),
            checkBoxButton.topAnchor.constraint(equalTo: topAnchor, constant: grid.largeOffset),
            checkBoxButton.heightAnchor.constraint(equalToConstant: Constants.sideSize),
            checkBoxButton.widthAnchor.constraint(equalToConstant: Constants.sideSize)
        ])
    }
}
