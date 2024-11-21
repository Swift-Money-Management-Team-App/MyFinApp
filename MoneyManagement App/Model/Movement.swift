import Foundation
import SwiftData

@Model
final class Movement {
    
    #Unique<Movement>([\.id], [])
    
    var id: UUID
    var idAccount: UUID
    /// Conta que será enviada, ou seja, somente do caso se for transferido em uma das contas registras do App.
    var destiny: UUID?
    var earningCategory: UUID?
    var expenseCategory: UUID?
    var transactionDescription: String?
    var total: Double
    var date: Date
    
    init(idAccount: UUID, destiny: UUID? = nil, earningCategory: UUID? = nil, expenseCategory: UUID? = nil, description: String? = nil, total: Decimal, date: Date) {
        self.id = UUID()
        self.idAccount = idAccount
        self.destiny = destiny
        self.earningCategory = earningCategory
        self.expenseCategory = expenseCategory
        self.transactionDescription = description
        self.total = 0
        self.date = Date.now
    }
    
}
