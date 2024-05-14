//
//  ResultCell.swift
//  TasksBook
//
//  Created by Mac on 17.02.2024.
//

import UIKit

class ResultCell: UICollectionViewCell {
    static let reuseID = "ResultCell"
    
    let label = UILabel(text: "ВСЕГО ЗАДАЧ: 5", isBold: true, size: 20)
    let iconImageView = UIImageView(image: .init(systemName: "list.bullet.rectangle"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    func setViews() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .customBlue
        layer.cornerRadius = 12
    }
    
    func setConstraints() {
        let stack = UIStackView(views: [iconImageView,
                                        label],
                                axis: .horizontal,
                                spacing: 12)
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
