import Foundation
import SwiftData

@Model
final class ExpenseCategory {
    
    #Unique<ExpenseCategory>([\.id], [])
    
    var id: UUID
    var idUser: UUID
    var emoji: String
    var name: String
    
    init(idUser: UUID, emoji: String, name: String) {
        self.id = UUID()
        self.idUser = idUser
        self.emoji = emoji
        self.name = name
    }
    
}

let expenseCategoryStandard = [
    (emoji: "fork.knife", name: "Alimentação"),
    (emoji: "bus", name: "Transporte"),
    (emoji: "popcorn", name: "Entretenimento"),
    (emoji: "drop", name: "Água"),
    (emoji: "bolt", name: "Luz")
]
