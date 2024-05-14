//
//  ToDoDetailView.swift
//  TasksBook
//
//  Created by Mac on 12.02.2024.
//

import UIKit

class TodoView: UIView {
    
    let titleLabel = UILabel(text: "Название задачи", isBold: true, size: 20)
    let descriptionTV = UITextView()
    let categoryLabel = UILabel(text: "Неважное несрочное", isBold: false, size: 16)
    let deadlineLabel = UILabel(text: "Выолнить до 14.02.2024", isBold: true, size: 16)
    let completeButton = UIButton(title: "Готово", hasBG: true)
    
    
    init() {
        super.init(frame: .zero)

        setViews()
        setContraints()
    }
    
    func setViews() {
        backgroundColor = .white
        descriptionTV.isEditable = false
    }
    
    func setContraints() {
        let categoryDeadlineStack = UIStackView(views: [categoryLabel, deadlineLabel], axis: .horizontal, spacing: 12)
        let mainStack = UIStackView(views: [titleLabel, categoryDeadlineStack, descriptionTV, completeButton], axis: .vertical, spacing: 12)
        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            mainStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
