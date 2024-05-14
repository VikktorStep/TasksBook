//
//  ToDoCatalogView.swift
//  TasksBook
//
//  Created by Mac on 03.02.2024.
//

import UIKit

class TodoCatalogView: UIView {
    var collectionView: UICollectionView!
    var tableView = UITableView()
    let addToDoButton = UIButton(type: .system)
    
    init () {
        super.init(frame: .zero)
        backgroundColor = .white
        setupCollectionView()
        setupTableView()
        setupAddToDoButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAddToDoButton() {
        addToDoButton.setTitle("+", for: .normal)
        addToDoButton.backgroundColor = .systemBlue
        addToDoButton.tintColor = .white
        addToDoButton.titleLabel?.font = .systemFont(ofSize: 30)
        addToDoButton.layer.cornerRadius = 32
        addToDoButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addToDoButton)
        
        NSLayoutConstraint.activate([
            addToDoButton.heightAnchor.constraint(equalToConstant: 64),
            addToDoButton.widthAnchor.constraint(equalToConstant: 64),
            addToDoButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            addToDoButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80)
        ])
        
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: collectionView.leftAnchor),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.reuseID)
        tableView.separatorStyle = .none
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 64),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        collectionView.backgroundColor = .white
        
        collectionView.register(CollectionCell.self, 
                                forCellWithReuseIdentifier: CollectionCell.reuseID)
        collectionView.register(ResultCell.self,
                                forCellWithReuseIdentifier: ResultCell.reuseID)
        
        collectionView.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
}

#Preview {
    CatalogController()
}
