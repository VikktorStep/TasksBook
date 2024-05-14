//
//  ToDoCategotyController.swift
//  TasksBook
//
//  Created by Mac on 04.02.2024.
//

import UIKit

class CategoryController: UIViewController {
    var category: TodoType = .urgentImportant
    let mainView = CategoryView()
    var todos: [Todo] = []
    var searchedTodos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        navigationItem.title = category.rawValue
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        navigationController?.navigationBar.isHidden = false
        self.todos = Todo.getAll(byCategory: category)
        mainView.tableView.reloadData()
        addActions()
        self.searchedTodos = self.todos
    }
    
    func addActions() {
        let searchTap = UIAction { [weak self] _ in
            guard let searchText = self?.mainView.searchTF.text?.lowercased() else { return }
            guard !searchText.isEmpty else {
                self?.searchedTodos = self?.todos ?? []
                self?.mainView.tableView.reloadData()
                return
            }
            
            let searchedTodos = self?.todos.filter { todo in
                todo.title.lowercased().contains(searchText)
            }
            
            self?.searchedTodos = searchedTodos ?? []
            self?.mainView.tableView.reloadData()
        }
        self.mainView.searchButton.addAction(searchTap, for: .touchUpInside)
    }
}

extension CategoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseID, for: indexPath) as! TodoCell
        let currentTodo = self.searchedTodos[indexPath.row]
        cell.titleLabel.text = currentTodo.title
        cell.indicatorView.backgroundColor = getColorBy(todoType: currentTodo.type)
        cell.deadlineLabel.text = stringValueFrom(date: currentTodo.deadline)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = self.searchedTodos[indexPath.row]
        let vc = TodoController(todo: todo)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
