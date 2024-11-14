
import UIKit

class AddTodoView: UIView {
    let titleLabel = UILabel(text: "Новая задача", isBold: true, size: 20)
    let todoTitleTF = UITextField(placeholder: "Название задачи")
    let descLabel = UILabel(text: "Введите описание:", isBold: true, size: 13)
    let todoDescriptionTextView = UITextView()
    let urgentSwitch = UISwitch()
    let urgentLabel = UILabel(text: "Важная?", isBold: false, size: 14)
    let importantSwitch = UISwitch()
    let importantLabel = UILabel(text: "Срочная?", isBold: false, size: 14)
    let deadlineDatePicker = UIDatePicker()
    let saveButton = UIButton(title: "Сохранить", hasBG: true)
    var isNew: Bool
    let completeButton = UIButton(title: "Выполнено", hasBG: true)
    let checkpointsTableView = UITableView()
    let addChckpointsButton = UIButton(title: "+ Чекпоинт", hasBG: true)
  
    init(isNew: Bool) {
        self.isNew = isNew
        super.init(frame: .zero)
        setViews()
        setConstraints()
    }
    
    func setViews() {
        backgroundColor = .white
        todoDescriptionTextView.layer.borderColor = UIColor.black.cgColor
        todoDescriptionTextView.layer.borderWidth = 0.2
        todoDescriptionTextView.layer.cornerRadius = 16
        
        deadlineDatePicker.datePickerMode = .date
        deadlineDatePicker.preferredDatePickerStyle = .automatic
        deadlineDatePicker.minimumDate = Date()
        
        checkpointsTableView.register(CheckpointCell.self, forCellReuseIdentifier: CheckpointCell.reuseID)
        checkpointsTableView.separatorStyle = .none
    }
    
    func setConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
        
        let urgentStack = UIStackView(views: [urgentLabel, urgentSwitch], axis: .horizontal, spacing: 12)
        
        let importantStack = UIStackView(views: [importantLabel, importantSwitch], axis: .horizontal, spacing: 12)
        
        let descriptionStack = UIStackView(views: [descLabel, todoDescriptionTextView], axis: .vertical, spacing: 4)
        
        let checkpointDeadlineStack = UIStackView(views: [addChckpointsButton, deadlineDatePicker], axis: .horizontal, spacing: 12)
        
        let mainStack = UIStackView(views: [todoTitleTF,
                                            urgentStack,
                                            importantStack,
                                            descriptionStack,
                                            checkpointDeadlineStack,
                                            checkpointsTableView,
                                            saveButton],
                                    axis: .vertical,
                                    spacing: 10)
        if !isNew {
            mainStack.addArrangedSubview(completeButton)
        }
        
        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            mainStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            mainStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        todoDescriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addChckpointsButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview {
    AddTodoController()
}
