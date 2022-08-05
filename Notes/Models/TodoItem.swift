//
//  TodoItem.swift
//  Notes
//
//  Created by Vlad Sytnik on 27.07.2022.
//

import Foundation

enum Priority: String {
    case hight
    case normal
    case low
}

struct TodoItem {
    var id = UUID().uuidString
    let text: String
    let priority: Priority
    var deadline: Date?
    var isCompleted: Bool = false
    let createdDate: Date
    var changedDate: Date?
}
