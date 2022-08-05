//
//  ViewController.swift
//  Notes
//
//  Created by Vlad Sytnik on 27.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = TodoItem(
            id: "id",
            text: "test",
            priority: .low,
            deadline: Date(),
            isCompleted: true,
            createdDate: Date(),
            changedDate: Date()
        )
        
        let json = item.json
//        print("JSON:")
//        print(json)
        
        guard let object = TodoItem.parse(json: json) else {return}
//        print("Объект:")
//        print(object)
        
        let fileManager = FileCache.shared
        fileManager.addTask(item)
        fileManager.addTask(item)
        
        print(fileManager.todoItems)
        
        fileManager.removeTask(item)
        print(fileManager.todoItems)
    }


}

