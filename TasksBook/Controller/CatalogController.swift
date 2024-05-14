//
//  ToDoCatalogController.swift
//  TasksBook
//
//  Created by Mac on 03.02.2024.
//

import UIKit

let screen =  UIScreen.main.bounds

class CatalogController: UIViewController {
    let mainView = TodoCatalogView()
    var todos: [Todo] = Todo.getAll(byCategory: nil)
    
    var sortedTodos: [Todo] {
        return todos.sorted().filter { todo in
            !todo.isComplete
        } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        addActions()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        self.todos = Todo.getAll(byCategory: nil)
        self.mainView.tableView.reloadData()
        self.tabBarController?.viewControllers?[0].tabBarItem.badgeValue = "\(sortedTodos.count)"
        updateViews()
    }
    
    func updateViews() {
        self.todos = Todo.getAll(byCategory: nil)
        self.mainView.tableView.reloadData()
        self.mainView.collectionView.reloadData()
    }
    
    func addActions() {
        let addToDoButtonTap = UIAction {_ in
            let vc = AddTodoController()
            vc.addToDoDelegate = self
            self.present(vc, animated: true)
        }

        mainView.addToDoButton.addAction(addToDoButtonTap, for: .touchUpInside)
    }
}

extension CatalogController: AddTodoDelagate {
    func addToDo(_ todo: Todo) {
        self.todos = Todo.getAll(byCategory: nil)
        updateViews()
    }
}

extension CatalogController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TodoType.allCases.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < TodoType.allCases.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseID, for: indexPath) as! CollectionCell
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 12
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOpacity = 0.6
            cell.layer.shadowOffset = .zero
            cell.layer.shadowRadius = 8
            cell.imageView.image = getImageForCell(TodoType.allCases[indexPath.item])
            cell.titleLabel.text = TodoType.allCases[indexPath.item].rawValue
            cell.imageView.tintColor = getColorBy(todoType:(TodoType.allCases[indexPath.item]))

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCell.reuseID, for: indexPath) as! ResultCell
            cell.label.text = "ВСЕГО задач: \(self.sortedTodos.count)"

            return cell
        }
        
        func getImageForCell(_ type: TodoType) -> UIImage {
            switch type {
            case .urgentImportant:
                return UIImage(systemName: "alarm.waves.left.and.right.fill")!
                
            case .notUrgentImportant:
                return UIImage(systemName: "clock.badge.exclamationmark")!
                
            case .urgentNotImportant:
                return UIImage(systemName: "clock.badge.exclamationmark.fill")!
                
            case .notUrgentNotImportant:
                return UIImage(systemName: "clock.badge.exclamationmark")!
            }
        }
    }
}

extension CatalogController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row < TodoType.allCases.count {
            .init(width: screen.width / 2 - 32, height: screen.width / 2 - 32)
        } else {
            .init(width: screen.width - 32, height: 64)
        }
    }
}

extension CatalogController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < TodoType.allCases.count {
            let vc = CategoryController()
            vc.category = TodoType.allCases[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CatalogController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseID) as! TodoCell
        let currrentTodo = self.sortedTodos[indexPath.row]
        cell.backgroundColor = .white
        cell.titleLabel.text = currrentTodo.title
        cell.deadlineLabel.text = stringValueFrom(date: currrentTodo.deadline)
        cell.indicatorView.backgroundColor = getColorBy(todoType: currrentTodo.type)
        return cell
    }
    
}

extension CatalogController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _, _, _ in
            let currentTodo = self?.sortedTodos[indexPath.row]
            currentTodo?.delete()
            self?.updateViews()
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Выполнено!") { [weak self] _, _,_ in
            let currentTodo = self?.sortedTodos[indexPath.row]
            currentTodo?.makeComplete()
            self?.updateViews()
        }
        let config = UISwipeActionsConfiguration(actions: [completeAction])
        return config
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = self.sortedTodos[indexPath.row]
        let vc = TodoController(todo: todo)
        navigationController?.pushViewController(vc, animated: true)
    }
}


