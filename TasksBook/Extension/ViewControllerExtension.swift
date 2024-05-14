//
//  ViewControllerExtension.swift
//  TasksBook
//
//  Created by Mac on 11.02.2024.
//

import UIKit

extension UIViewController {
    
    func getColorBy(todoType: TodoType) -> UIColor {
        switch todoType {
        case .urgentImportant: return .systemRed
        case .notUrgentImportant: return .systemGreen
        case .notUrgentNotImportant: return .systemMint
        case .urgentNotImportant: return .systemYellow
        }
    }
    
    func stringValueFrom(date: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yy"
        let stringDate = formater.string(from: date)
        return stringDate
    }

    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func addTapToHideKB () {
        let tap = UITapGestureRecognizer(target: self, action: #selector (hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
}
