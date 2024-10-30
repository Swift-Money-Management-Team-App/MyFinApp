import Foundation
import SwiftData

@Model
final class BankAccount {
    
    #Unique<BankAccount>([\.id], [])
    
    var id: UUID
    var idUser: UUID
    var name: String
    var total: Double
    
    init(idUser: UUID, name: String) {
        self.id = UUID()
        self.idUser = idUser
        self.name = name
        self.total = 0
    }
    
}
