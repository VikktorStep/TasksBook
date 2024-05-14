//
//  UILabelExtension.swift
//  TasksBook
//
//  Created by Mac on 11.02.2024.
//

import UIKit

extension UILabel {
    convenience init(text: String, isBold: Bool, size: CGFloat) {
        self.init()
        self.text = text
        self.textAlignment = .left
        self.font = isBold ? .boldSystemFont(ofSize: size) : .systemFont(ofSize: size)
    }
}

