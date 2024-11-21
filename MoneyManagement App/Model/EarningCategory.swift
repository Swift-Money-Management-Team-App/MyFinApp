import Foundation
import SwiftData

@Model
final class EarningCategory {
    
    #Unique<EarningCategory>([\.id], [])
    
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

let earningCategoryStandard =  [
    (emoji: "wallet.bifold", name: "Salário"),
    (emoji: "percent", name: "Juros"),
    (emoji: "text.page.slash", name: "Recisão"),
    (emoji: "scroll.fill", name: "Indenização"),
    (emoji: "brazilianrealsign.bank.building", name: "Loteria")
]
