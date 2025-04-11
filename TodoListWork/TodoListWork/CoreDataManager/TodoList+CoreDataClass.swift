//
//  TodoList+CoreDataClass.swift
//  TodoListWork
//
//  Created by Abubakar Bibulatov on 10.04.2025.
//
//

import Foundation
import CoreData

@objc(TodoList)
public class TodoList: NSManagedObject {

}

extension TodoList {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self.creationDate ?? Date())
    }
}
