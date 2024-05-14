//
//  UIButtonExtension.swift
//  TasksBook
//
//  Created by Mac on 11.02.2024.
//

import UIKit

extension UIButton {
    convenience init(title: String, hasBG: Bool) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        backgroundColor = hasBG ? .customPink : .white
        tintColor = hasBG ? .white : .customPink
        layer.cornerRadius = 12
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
