//
//  TFExtension.swift
//  TasksBook
//
//  Created by Mac on 31.01.2024.
//

import UIKit

extension UITextField {
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.backgroundColor = .white
        self.placeholder = placeholder
        self.layer.cornerRadius = 12
        self.leftView = UIView(frame: .init(x: 0, y: 0, width: 12, height: 0))
        self.leftViewMode = .always
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
}
