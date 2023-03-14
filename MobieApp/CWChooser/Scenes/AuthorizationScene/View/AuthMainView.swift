//
//  AuthMainView.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 11.02.2023.
//

import Foundation
import UIKit
import Combine

final class AuthMainView: UIView {
    
    typealias LOC = Localization.AuthViewController
    private let grid = Grid()
    private var buttonSubject: PassthroughSubject<(login: String, password: String), Never>?
    
    /// Картинка воронов
    private let crowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.crowImage)
        return imageView
    }()
    
    /// Кнопка авторизации
    private let authButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LOC.titleButtonAuth, for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(named: Constants.buttonBackground)
        button.layer.cornerRadius = Constants.cornerRadius
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
        return button
    }()
    
    /// Заголовок над кнопкой ввода логина
    private let titleLoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.text = LOC.titleLogin
        return label
    }()
    
    /// Поле ввода логина
    private let loginInputField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.cornerRadius = Constants.cornerRadius
        field.clipsToBounds = true
        field.layer.borderWidth = 0.2
        field.layer.borderColor = UIColor.systemGray.cgColor
        field.textColor = .white
        field.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        field.attributedPlaceholder = NSAttributedString(
            string: LOC.fieldLoginText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        return field
    }()
    
    /// Заголовок над кнопкой ввода пароля
    private let titlePasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.text = LOC.titlePassword
        return label
    }()
    
    /// Поле ввода пароля
    private let passwordInputField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isSecureTextEntry = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.clipsToBounds = true
        field.layer.borderWidth = 0.2
        field.layer.borderColor = UIColor.systemGray.cgColor
        field.textColor = .white
        field.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        field.attributedPlaceholder = NSAttributedString(
            string: LOC.fieldPasswordText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        return field
    }()
    
    convenience init(frame: CGRect, buttonSubject: PassthroughSubject<(login: String, password: String), Never>?) {
        self.init(frame: frame)
        self.buttonSubject = buttonSubject
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: Constants.background)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AuthMainView {
    enum Constants {
        static let crowImage: String = "hseCrow"
        static let background: String = "hseBackground"
        static let buttonBackground: String = "HseBlue"
        static let heightField: CGFloat = 40
        static let heightButton: CGFloat = 50
        static let verticalItemOffset: CGFloat = 24
        static let topImageOffset: CGFloat = 220
        static let heightImage: CGFloat = 140
        static let cornerRadius: CGFloat = 12
    }
    
    func setupLayout() {
        addSubview(crowImage)
        addSubview(titleLoginLabel)
        addSubview(loginInputField)
        addSubview(titlePasswordLabel)
        addSubview(passwordInputField)
        addSubview(authButton)
        
        NSLayoutConstraint.activate([
            crowImage.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topImageOffset),
            crowImage.heightAnchor.constraint(equalToConstant: Constants.heightImage),
            crowImage.widthAnchor.constraint(equalToConstant: Constants.topImageOffset),
            crowImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLoginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: grid.xlargeOffset),
            titleLoginLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -grid.xlargeOffset),
            
            loginInputField.topAnchor.constraint(equalTo: titleLoginLabel.bottomAnchor, constant: grid.largeOffset),
            loginInputField.leadingAnchor.constraint(equalTo: titleLoginLabel.leadingAnchor),
            loginInputField.trailingAnchor.constraint(equalTo: titleLoginLabel.trailingAnchor),
            loginInputField.heightAnchor.constraint(equalToConstant: Constants.heightField),
            
            titlePasswordLabel.topAnchor.constraint(equalTo: loginInputField.bottomAnchor, constant: Constants.verticalItemOffset),
            titlePasswordLabel.leadingAnchor.constraint(equalTo: titleLoginLabel.leadingAnchor),
            titlePasswordLabel.trailingAnchor.constraint(equalTo: titleLoginLabel.trailingAnchor),
            
            passwordInputField.topAnchor.constraint(equalTo: titlePasswordLabel.bottomAnchor, constant: grid.largeOffset),
            passwordInputField.leadingAnchor.constraint(equalTo: titleLoginLabel.leadingAnchor),
            passwordInputField.trailingAnchor.constraint(equalTo: titleLoginLabel.trailingAnchor),
            passwordInputField.heightAnchor.constraint(equalToConstant: Constants.heightField),
            
            authButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -grid.largeOffset),
            authButton.topAnchor.constraint(equalTo: passwordInputField.bottomAnchor, constant: Constants.verticalItemOffset),
            authButton.leadingAnchor.constraint(equalTo: titleLoginLabel.leadingAnchor),
            authButton.trailingAnchor.constraint(equalTo: titleLoginLabel.trailingAnchor),
            authButton.heightAnchor.constraint(equalToConstant: Constants.heightButton)
        ])
    }
    
    @objc
    func tapOnButton() {
        print("tap1")
        if let login = loginInputField.text,
           let password = passwordInputField.text {
            buttonSubject?.send((login, password))
        }
    }
}
