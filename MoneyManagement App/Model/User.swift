import Foundation
import SwiftData

@Model
final class User {
    
    #Unique<User>([\.id], [])
    
    var id: UUID
    var name: String
    
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
    
}
