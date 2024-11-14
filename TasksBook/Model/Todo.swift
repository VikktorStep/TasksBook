//
//  ToDo.swift
//  TasksBook
//
//  Created by Mac on 03.02.2024.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted (primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var descrip: String
    @Persisted var isComplete: Bool = false
    @Persisted var type: TodoType
    @Persisted var deadline: Date = Date()
    @Persisted var checkpoints: List<Checkpoint>
    
    convenience init(title: String, description: String, type: TodoType, deadline: Date) {
        self.init()
        self.id = id
        self.title = title
        self.descrip = description
        self.type = type
        self.deadline = deadline
    }
    
    // MARK: CRUD Operations
    
    //Create
    static func create(_ todo: Todo) {
        let realm = try! Realm()
        try? realm.write {
            realm.add(todo)
        }
    }
    
    //Retrieve
    static func getAll(byCategory category: TodoType?) -> [Todo] {
        let realm = try! Realm()
        let todos = realm.objects(Todo.self)
        if let category {
            let todos = realm.objects(Todo.self).filter { todo in
                todo.type == category
            }
            var array = [Todo]()
            todos.forEach { array.append($0) }
            return array
        } else {
            var array = [Todo]()
            todos.forEach { array.append($0) }
            return array
        }
    }
    
    //Update
    func makeComplete() {
        let realm = try! Realm()
        try? realm.write {
            self.isComplete = true
        }
    }
    
    func updateTodo(updatedTodo: Todo) {
        let realm = try! Realm()
        try? realm.write {
            self.deadline = updatedTodo.deadline
            self.type = updatedTodo.type
            self.title = updatedTodo.title
            self.isComplete = updatedTodo.isComplete
            self.descrip = updatedTodo.descrip
        }
    }
    
    func addCheckpoints(checkpoint: Checkpoint) {
        let realm = try! Realm()
        try? realm.write {
            self.checkpoints.append(checkpoint)
        }
    }
   
    //Delete
    func delete() {
        let realm = try! Realm()
        try? realm.write {
            self.checkpoints.forEach { realm.delete($0) }
            realm.delete(self)
        }
    }
}

extension Todo: Comparable {
    static func < (lhs: Todo, rhs: Todo) -> Bool {
        let allTypes = TodoType.allCases
        let leftIndex = allTypes.firstIndex(of: lhs.type)!
        let rightIndex = allTypes.firstIndex(of: rhs.type)!
        if leftIndex != rightIndex {
            return leftIndex < rightIndex
        } else {
            return lhs.deadline < rhs.deadline
        }
    }
}
