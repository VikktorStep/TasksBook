//
//  ViewController.swift
//  TasksBook
//
//  Created by Mac on 30.01.2024.
//

import UIKit

class SettingsController: UIViewController {
    
    let mainView = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        addTapToHideKB()
    }


}
