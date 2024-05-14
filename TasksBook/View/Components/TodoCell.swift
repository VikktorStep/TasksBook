//
//  ToDoCellTableViewCell.swift
//  TasksBook
//
//  Created by Mac on 04.02.2024.
//

import UIKit

class TodoCell: UITableViewCell {
    static let reuseID = "TodoCell"
    let cardView = UIView()
    let indicatorView = UIView()
    let titleLabel = UILabel()
    let deadlineLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = .none
        setViews()
        setConstraints()
    }
    
    
    func setViews() {
        titleLabel.text = "Название задачи"
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textAlignment = .left
        deadlineLabel.text = "05.02.2024"
        deadlineLabel.textAlignment = .left
        deadlineLabel.font = .systemFont(ofSize: 12)
        backgroundColor = .clear
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOpacity = 0.6
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 8
        indicatorView.backgroundColor = .green
        indicatorView.layer.cornerRadius = 5
    }
    
    func setConstraints() {
        let stack = UIStackView(views: [indicatorView,
                                        titleLabel,
                                        deadlineLabel],
                                axis: .horizontal,
                                spacing: 5)
        addSubview(cardView)
        cardView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 12),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            deadlineLabel.widthAnchor.constraint(equalToConstant: 80),
            indicatorView.widthAnchor.constraint(equalToConstant: 10),
            indicatorView.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            // Выделение произошло
            // Измените цвет фона на розовый
            self.contentView.backgroundColor = .customPink
        } else {
            // Ячейка потеряла выделение
            // Верните исходный цвет фона
            self.contentView.backgroundColor = .clear
        }
    }
    
}
