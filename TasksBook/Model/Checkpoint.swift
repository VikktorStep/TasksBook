//
//  Checkpoint.swift
//  TasksBook
//
//  Created by Mac on 23.02.2024.
//

import RealmSwift

class Checkpoint: Object {
    @Persisted (primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var isComplete: Bool = false
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    static func getBy(_ todo: Todo) -> [Checkpoint] {
        let realm = try! Realm()
        guard todo == realm.object(ofType: Todo.self, forPrimaryKey: todo.id) else { return [] }
        let pointsList = Array(todo.checkpoints)
        return pointsList
    }
    
    func makeComplete() {
        let realm = try! Realm()
        try? realm.write {
            self.isComplete = true
        }
    }
    
    func delete() {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(self)
        }
    }
    
}
