//
//  CoreDataManager.swift
//  TodoListWork
//
//  Created by Abubakar Bibulatov on 10.04.2025.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    var todos: [TodoList] = []
    
    private init() {
        fetchAllTodos()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllTodos() {
        let request = TodoList.fetchRequest()
        if let todos = try? persistentContainer.viewContext.fetch(request) {
            self.todos = todos
        }
    }
    
    func addNewTodo(title: String, text: String) {
        let todo = TodoList(context: persistentContainer.viewContext)
        todo.id = UUID().uuidString
        todo.title = title
        todo.text = text
        todo.creationDate = Date()
        
        saveContext()
        fetchAllTodos()
    }
    
}
