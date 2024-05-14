//
//  ToDoTypeCell.swift
//  TasksBook
//
//  Created by Mac on 03.02.2024.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    static var reuseID: String = "ToDoCell"
    
    let titleLabel = UILabel()
    let imageView = UIImageView(image: .checkmark)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    func setViews() {
        titleLabel.text = TodoType.urgentImportant.rawValue
        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        imageView.contentMode = .scaleAspectFit
    }
    
    func setConstraints() {
        let stack = UIStackView(views: [imageView, titleLabel],
                                axis: .vertical,
                                spacing: 5)
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
