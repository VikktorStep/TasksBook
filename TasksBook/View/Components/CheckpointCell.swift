//
//  CheckpointCell.swift
//  TasksBook
//
//  Created by Mac on 24.02.2024.
//

import UIKit

class CheckpointCell: UITableViewCell {
    static let reuseID = "CheckpointCell"
    let titleLabel = UILabel(text: "Чекпоинт", isBold: false, size: 16)
    let completeImageView = UIImageView(image: UIImage(systemName: "circle"))
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    func setViews() {
        
    }
    
    func setConstraints() {
        let stack = UIStackView(views: [completeImageView, titleLabel], axis: .horizontal, spacing: 8)
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            completeImageView.heightAnchor.constraint(equalToConstant: 24),
            completeImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
