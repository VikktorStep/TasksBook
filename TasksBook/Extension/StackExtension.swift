//
//  StackExtension.swift
//  TasksBook
//
//  Created by Mac on 31.01.2024.
//

import UIKit

extension UIStackView {
    convenience init(
        views: [UIView],
        alignment: Alignment = .fill,
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat
    ) {
        
        self.init(arrangedSubviews: views)
        self.alignment = alignment
        self.axis = axis
        self.spacing = spacing
    }
}
