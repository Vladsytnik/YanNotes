//
//  TodoItem + JSON.swift
//  Notes
//
//  Created by Vlad Sytnik on 27.07.2022.
//

import Foundation

extension TodoItem {
    var json: Any {
        do {
            let dict = getDictionary()
            let data = try JSONSerialization.data(
                withJSONObject: dict,
                options: .fragmentsAllowed
            )
            let json = try JSONSerialization.jsonObject(
                with: data,
                options: .fragmentsAllowed
            )
            return json
        } catch {
            print("--- Ошибка в TodoItem -> json ---")
            print(error)
            return Any.self
        }
    }
    
    static func parse(json: Any) -> TodoItem? {
        do {
            let data = try JSONSerialization.data(
                withJSONObject: json,
                options: .fragmentsAllowed
            )
            let json = try JSONSerialization.jsonObject(
                with: data,
                options: .fragmentsAllowed
            ) as? [String: Any]
            
            let object = getObject(from: json)
            return object
        } catch {
            print(error)
            return nil
        }
    }
    
    static private func getDate(from str: String?) -> Date? {
        guard let strDate = str else {return nil}
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        
        let date = RFC3339DateFormatter.date(from: strDate)
        return date
    }
    
    static private func getObject(from json: [String : Any]?) -> TodoItem? {
        TodoItem(
            id: json!["id"] as! String,
            text: json!["text"] as? String ?? "",
            priority: Priority.init(
                rawValue: (json?["priority"] as? String) ?? "normal"
            )!,
            deadline: getDate(from: json?["deadline"] as? String),
            isCompleted: json!["isCompleted"] as! Bool,
            createdDate: getDate(
                from: json?["createdDate"] as? String
            ) ?? Date(),
            changedDate: getDate(from: json?["changedDate"] as? String)
        )
    }
    
    private func getDictionary() -> [NSString: Any] {
        var dict: [NSString: Any] = [:]
        
        dict["id"] = self.id
        dict["text"] = self.text
        dict["isCompleted"] = self.isCompleted
        dict["createdDate"] = self.createdDate.description
        dict["changedDate"] = self.changedDate?.description
        
        if self.priority != .normal {
            dict["priority"] = self.priority.rawValue
        }
        if self.deadline != nil {
            dict["deadline"] = self.deadline?.description
        }
        
        return dict
    }
}
