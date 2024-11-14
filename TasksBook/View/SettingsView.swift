
import UIKit

class SettingsView: UIView {
    let titleLabel = UILabel()
    let nameTF = UITextField(placeholder: "Ваше имя")
    let ageTF = UITextField (placeholder: "Ваш возраст")
    let cardView = UIView()
    let saveButton = UIButton(type: .system)
    let viewImage = UIImageView(image: .logo)
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        setViews()
        setConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        titleLabel.text = "Настройки"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        cardView.backgroundColor = .white
        titleLabel.textAlignment = .center
        cardView.layer.cornerRadius = 30
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.tintColor = .white
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 12
        viewImage.layer.shadowOffset = .zero
        viewImage.layer.shadowOpacity = 1
        viewImage.layer.shadowRadius = 4
        viewImage.layer.shadowColor = UIColor.black.cgColor
    }
    
    func setConstaints() {
        let stack = UIStackView(views: [titleLabel, nameTF, ageTF, saveButton],
                                axis: .vertical,
                                spacing: 12)
        stack.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(stack)
        addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewImage)
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            cardView.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            stack.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 30),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            viewImage.widthAnchor.constraint(equalToConstant: 150),
            viewImage.heightAnchor.constraint(equalToConstant: 150),
            viewImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewImage.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -30)
        ])
    }
}

#Preview {
    SettingsController()
}


