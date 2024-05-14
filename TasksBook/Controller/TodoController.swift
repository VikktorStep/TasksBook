//
//  ToDoDetailController.swift
//  TasksBook
//
//  Created by Mac on 12.02.2024.
//

import UIKit

class TodoController: AddTodoController {
    let todo: Todo
    
    init(todo: Todo) {
        self.todo = todo
        super.init(nibName: nil, bundle: nil)
        self.checkpoints = Checkpoint.getBy(todo)
        self.mainView = AddTodoView(isNew: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        navigationController?.navigationBar.isHidden = false
        setViews()
    }
    
    func setViews() {
        mainView.deadlineDatePicker.minimumDate = nil
        mainView.todoTitleTF.text = todo.title
        mainView.titleLabel.text = "Задача"
        mainView.deadlineDatePicker.date = todo.deadline
        mainView.todoDescriptionTextView.text = todo.descrip
        switch todo.type {
        case .urgentImportant:
            mainView.urgentSwitch.isOn = true
            mainView.importantSwitch.isOn = true
        case .notUrgentImportant:
            mainView.urgentSwitch.isOn = false
            mainView.importantSwitch.isOn = true
        case .urgentNotImportant:
            mainView.urgentSwitch.isOn = true
            mainView.importantSwitch.isOn = false
        case .notUrgentNotImportant:
            mainView.urgentSwitch.isOn = false
            mainView.importantSwitch.isOn = false
        }

        if todo.isComplete {
        }
        addActions()
    }

    override func addActions() {
        let completeTap = UIAction { [unowned self] _ in
            todo.makeComplete()
            navigationController?.popViewController(animated: true)
        }

        let saveTap = UIAction { [weak self] _ in
            guard let title = self?.mainView.todoTitleTF.text else { return }
            guard let desc = self?.mainView.todoDescriptionTextView.text else { return }
            let deadline = self?.mainView.deadlineDatePicker.date
            let urgent = self?.mainView.urgentSwitch.isOn
            let important = self?.mainView.importantSwitch.isOn
            let type = TodoType.init(urg: urgent ?? false, imp: important ?? false)
            let upd = Todo(title: title, description: desc, type: type, deadline: deadline ?? Date() )
            self?.todo.updateTodo(updatedTodo: upd)
            self?.navigationController?.popViewController(animated: true)
        }
        mainView.saveButton.addAction(saveTap, for: .touchUpInside)
        mainView.completeButton.addAction(completeTap, for: .touchUpInside)
        addActionCheckpoint()
    }
    
    override func addActionCheckpoint() {
        let addChecpointAction = UIAction { _ in
            let alert = UIAlertController(title: "Добавьте чекпоинт", message: nil, preferredStyle: .alert)
            alert.addTextField { tf in
                tf.placeholder = "Введи текст"
            }
            
            let saveCheckpointTap = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
                guard let title = alert.textFields?[0].text else { return }
                let checkpoint = Checkpoint(title: title)
                self?.checkpoints.append(checkpoint)
                self?.todo.addCheckpoints(checkpoint: checkpoint)
                self?.mainView.checkpointsTableView.reloadData()
            }
            alert.addAction(saveCheckpointTap)
            alert.addAction(.init(title: "Отмена", style: .cancel))
            self.present(alert, animated: true)
        }
        mainView.addChckpointsButton.addAction(addChecpointAction, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
