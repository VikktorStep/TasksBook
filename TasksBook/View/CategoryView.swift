//
//  ToDoCategoryView.swift
//  TasksBook
//
//  Created by Mac on 12.02.2024.
//

import UIKit

class CategoryView: UIView {
    let tableView = UITableView()
    let searchTF = UITextField(placeholder: "Поиск...")
    let searchButton = UIButton(title: "Найти", hasBG: true)
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setViews()
        setConstraints()
        tableView.backgroundColor = .white
    }
    
    func setViews() {
        tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.reuseID)
        tableView.separatorStyle = .none
    }
    
    func setConstraints() {
        let searchStack = UIStackView(
            views: [searchTF, searchButton],
            axis: .horizontal,
            spacing: 12
        )
        
        let mainStack = UIStackView(
            views: [searchStack, tableView],
            axis: .vertical,
            spacing: 12
        )
        
        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([searchButton.widthAnchor.constraint(equalToConstant: 80)])
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            mainStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
