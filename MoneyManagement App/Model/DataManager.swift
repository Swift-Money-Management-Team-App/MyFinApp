import SwiftData
import Foundation

@Model
final class User {
    
    var id: UUID = UUID()
    var name: String
    
    @Relationship(deleteRule: .cascade)
    var bankAccounts: [BankAccount] = []
    
    init(name: String) {
        self.name = name
    }
}

@Model
final class BankAccount {
    
    var id: UUID = UUID()
    var name: String
    var total: Decimal
    
    @Relationship(deleteRule: .cascade)
    var accounts: [Account] = []
    var user: User?
    
    init(name: String, totalValue: Decimal) {
        self.name = name
        self.total = totalValue
    }
}

@Model
final class Account {
    
    var id: UUID = UUID()
    var name: String
    var total: Decimal
    var isCreditCard: Bool
    var closeDay: Int?
    
    @Relationship(deleteRule: .nullify)
    var transactionsAsOrigin: [Transaction] = []
    
    @Relationship(deleteRule: .nullify)
    var transactionsAsDestiny: [Transaction] = []
    
    var bankAccount: BankAccount?
    
    init(name: String, totalValue: Decimal, isCreditCard: Bool, closeDay: Int?, bankAccount: BankAccount? = nil) {
        self.name = name
        self.total = totalValue
        self.isCreditCard = isCreditCard
        self.closeDay = closeDay
        self.bankAccount = bankAccount
    }
}

@Model
final class Transaction: Identifiable {
    
    var id: UUID = UUID()
    var transactionDescription: String?
    var total: Decimal
    var date: Date
    
    @Relationship(deleteRule: .nullify)
    var destiny: Account?
    
    @Relationship(deleteRule: .nullify)
    var origin: Account?
    
    @Relationship(deleteRule: .cascade)
    var payments: [Payment] = []
    
    var category: Category?
    
    init(transactionDescription: String?, date: Date, totalValue: Decimal, destiny: Account?, origin: Account?) {
        self.transactionDescription = transactionDescription
        self.date = date
        self.total = totalValue
        self.destiny = destiny
        self.origin = origin
    }
}

@Model
final class Payment {
    
    var id: UUID = UUID()
    var value: Decimal
    var competence: Date?
    var origin: Account
    
    @Relationship(deleteRule: .nullify)
    var paymentMethod: Method?
    
    var transaction: Transaction?
    
    init(value: Decimal, competence: Date?, origin: Account, paymentMethod: Method? = nil, transaction: Transaction? = nil) {
        self.value = value
        self.competence = competence
        self.origin = origin
        self.paymentMethod = paymentMethod
        self.transaction = transaction
    }
}

@Model
final class Method {
    
    var id: UUID = UUID()
    var emoji: String
    var name: String
    var visible: Bool
    
    @Relationship(deleteRule: .nullify)
    var payments: [Payment] = []
    
    init(emoji: String, name: String, visible: Bool) {
        self.emoji = emoji
        self.name = name
        self.visible = visible
    }
}

@Model
final class Category {
    
    var id: UUID = UUID()
    var name: String
    var emoji: String?
    var visible: Bool
    var type: CategoryType
    
    init(name: String, emoji: String?, visible: Bool, type: CategoryType) {
        self.name = name
        self.emoji = emoji
        self.visible = visible
        self.type = type
    }
}

enum CategoryType: String, Codable {
    case earning
    case expense
}
