import Foundation
import SwiftData

@Model
final class Movement {
    
    #Unique<Movement>([\.id], [])
    
    var id: UUID
    var idUser: UUID
    var earningCategory: UUID?
    var expenseCategory: UUID?
    var transactionDescription: String?
    var total: Double
    var date: Date
    
    init(idUser: UUID, earningCategory: UUID? = nil, expenseCategory: UUID? = nil, description: String? = nil, total: Double, date: Date) {
        self.id = UUID()
        self.idUser = idUser
        self.earningCategory = earningCategory
        self.expenseCategory = expenseCategory
        self.transactionDescription = description
        self.total = total
        self.date = date
    }
    
}
