
import UIKit

protocol AddTodoDelagate: AnyObject {
    func addToDo(_ todo: Todo)
}

class AddTodoController: UIViewController {
    var mainView = AddTodoView(isNew: true)
    weak var addToDoDelegate: AddTodoDelagate?
    var checkpoints = [Checkpoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = mainView
        addActions()
        mainView.checkpointsTableView.dataSource = self
        mainView.checkpointsTableView.delegate = self
    }
    
    func addActions() {
        let saveButtonTap = UIAction { _ in
            guard let todo = self.createToDo() else {return}
            Todo.create(todo)
            self.addToDoDelegate?.addToDo(todo)
            for checkpoint in self.checkpoints {
                todo.addCheckpoints(checkpoint: checkpoint)
            }
            self.dismiss(animated: true)
        }
        mainView.saveButton.addAction(saveButtonTap, for: .touchUpInside)
        addActionCheckpoint()
    }
    
    func addActionCheckpoint() {
        let addChecpointAction = UIAction { _ in
            let alert = UIAlertController(title: "Добавьте чекпоинт", message: nil, preferredStyle: .alert)
            alert.addTextField { tf in
                tf.placeholder = "Введи текст"
            }
            
            let saveCheckpointTap = UIAlertAction(title: "Сохранить", style: .default) { [unowned self] _ in
                guard let title = alert.textFields?[0].text else { return }
                let checkpoint = Checkpoint(title: title)
                self.checkpoints.append(checkpoint)
                self.mainView.checkpointsTableView.reloadData()
            }
            alert.addAction(saveCheckpointTap)
            alert.addAction(.init(title: "Отмена", style: .cancel))
            self.present(alert, animated: true)
        }
        mainView.addChckpointsButton.addAction(addChecpointAction, for: .touchUpInside)
    }
    
    func createToDo() -> Todo? {
        guard let title = mainView.todoTitleTF.text else { return nil }
        guard let description = mainView.todoDescriptionTextView.text else { return nil }
        guard !title.isEmpty else { return nil }
        print(title)
        
        let isImportant = mainView.importantSwitch.isOn
        let isUrgent = mainView.urgentSwitch.isOn
        
        let type = switch (isImportant, isUrgent) {
        case (true, true): TodoType.urgentImportant
        case (true, false): TodoType.notUrgentImportant
        case (false, true): TodoType.urgentNotImportant
        case (false, false): TodoType.notUrgentNotImportant
        }
        
        let date = mainView.deadlineDatePicker.date
        
        let todo = Todo(title: title, description: description, type: type, deadline: date)
        print("Created Todo with title: \(todo.title), description: \(todo.description), type: \(todo.type), deadline: \(todo.deadline)")
        
        return todo
    }
}

extension AddTodoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.checkpoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CheckpointCell.reuseID) as! CheckpointCell
        let currentCheckpoint = self.checkpoints[indexPath.row]
        cell.titleLabel.text = currentCheckpoint.title
        cell.completeImageView.image = currentCheckpoint.isComplete ? UIImage(systemName: "circle.circle.fill") : UIImage(systemName: "circle")
        cell.titleLabel.textColor = currentCheckpoint.isComplete ? .lightGray : .black
        return cell
    }
}

extension AddTodoController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCheckpoint = self.checkpoints[indexPath.row]
        currentCheckpoint.makeComplete()
        mainView.checkpointsTableView.reloadData()
    }
}

