//
//  TabBarVC.swift
//  TasksBook
//
//  Created by Mac on 17.02.2024.
//

import UIKit
import RealmSwift

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let catalogVC = CatalogController()
        let settingsVC = SettingsController()
        let navVC = UINavigationController(rootViewController: catalogVC)
        
        navVC.tabBarItem.title = "Задачи"
        navVC.tabBarItem.image = UIImage(systemName: "list.clipboard")
        settingsVC.tabBarItem.title = "Настройки"
        settingsVC.tabBarItem.image = UIImage(systemName: "gear")
        self.tabBar.tintColor = .customPink
        self.tabBar.unselectedItemTintColor = .gray
        
        self.viewControllers = [ navVC, settingsVC ]
        
        let url = Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? ""
        print(url)
    }
}

