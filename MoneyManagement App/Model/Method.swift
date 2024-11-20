import Foundation
import SwiftData

@Model
final class Method {
    
    #Unique<Method>([\.id], [])
    
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

let methodStandard = [
    (emoji: "wallet.bifold", name: "Dinheiro"),
    (emoji: "creditcard", name: "Débito"),
    (emoji: "creditcard.and.123", name: "Crédito"),
    (emoji: "rectangle.and.pencil.and.ellipsis", name: "Cheque"),
    (emoji: "banknote", name: "Pix")
]
