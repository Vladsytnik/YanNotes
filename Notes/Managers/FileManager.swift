//
//  FileManager.swift
//  Notes
//
//  Created by Vlad Sytnik on 28.07.2022.
//
import Foundation

final class FileCache {
    
    static var shared = FileCache()
    private(set) var todoItems: [TodoItem]  = []
    
    private init() {}
    
    func addTask(_ newTask: TodoItem) {
        if isContained(newTask) { return }
        todoItems.append(newTask)
    }
    
    func removeTask(_ task: TodoItem) {
        let id = getIndexWith(task.id)
        guard let index = id else {return}
        
        todoItems.remove(at: index)
    }
    
    func loadJSON(withFilename filename: String) throws -> Any? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory,
                                       in: .userDomainMask)
        guard let url = urls.first else { return nil }
        let fileUrl = url
        _ = url.appendingPathComponent(filename)
        url.appendingPathExtension("json")
        
        let data = try Data(contentsOf: fileUrl)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])
        return jsonObject
        
        return nil
    }
    
    func save(jsonObject: Any, toFilename filename: String) throws -> Bool{
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            try data.write(to: fileURL, options: [.atomicWrite])
            return true
        }
        
        return false
    }
}

extension FileCache {
    private func isContained(_ newTask: TodoItem) -> Bool {
        todoItems.contains(where: { task in
            newTask.id == task.id
        })
    }
    
    private func getIndexWith(_ taskID: String) -> Int? {
        todoItems.firstIndex() { existTask in
            taskID == existTask.id
        }?.distance(to: 0)
    }
}
