import Foundation
import RealmSwift

enum TodoType: String, PersistableEnum ,CaseIterable {
    case urgentImportant = "Важное срочное"
    case notUrgentImportant = "Важное несрочное"
    case urgentNotImportant = "Неважное срочное"
    case notUrgentNotImportant = "Неважное несрочное"
    
    init(urg: Bool, imp: Bool) {
        switch (urg, imp) {
        case (true, true):
            self = .urgentImportant
        case (true, false):
            self = .urgentNotImportant
        case (false, true):
            self = .notUrgentImportant
        case (false, false):
            self = .notUrgentNotImportant
        }
    }
}
