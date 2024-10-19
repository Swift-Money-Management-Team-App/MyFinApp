import SwiftData
import Foundation

@Model
final class User {
    
    var id: UUID = UUID()
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \BankAccount.user)
    var bankAccounts: [BankAccount] = []
    
    init(name: String) {
        self.name = name
    }
}

@Model
final class BankAccount {
    
    var id: UUID = UUID()
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Account.bankAccount)
    var accounts: [Account] = []
    var user: User?
    
    init(name: String) {
        self.name = name
    }
}

@Model
final class Account {
    
    var id: UUID = UUID()
    var name: String
    var totalValue: Decimal
    var isCreditCard: Bool
    var closeDay: Int?
    
    var transactionsAsOrigin: [Transaction] = []
    var transactionsAsDestiny: [Transaction] = []
    
    var bankAccount: BankAccount?
    
    init(name: String, totalValue: Decimal, isCreditCard: Bool, closeDay: Int?, bankAccount: BankAccount? = nil) {
        self.name = name
        self.totalValue = totalValue
        self.isCreditCard = isCreditCard
        self.closeDay = closeDay
        self.bankAccount = bankAccount
    }
}

@Model
final class Transaction: Identifiable {
    
    var id: UUID = UUID()
    var transactionDescription: String?
    var date: Date
    
    @Relationship(deleteRule: .nullify, inverse: \Account.transactionsAsOrigin)
    var origin: Account?
    
    @Relationship(deleteRule: .nullify, inverse: \Account.transactionsAsDestiny)
    var destiny: Account?
    
    @Relationship(deleteRule: .cascade, inverse: \Payment.transaction)
    var payments: [Payment] = []
    
    @Relationship(deleteRule: .nullify, inverse: \EarningCategory.transaction)
    var earningCategory: EarningCategory?
    
    @Relationship(deleteRule: .nullify, inverse: \ExpenseCategory.transaction)
    var expenseCategory: ExpenseCategory?
    
    init(transactionDescription: String?, date: Date, origin: Account?, destiny: Account?) {
        self.transactionDescription = transactionDescription
        self.date = date
        self.origin = origin
        self.destiny = destiny
    }
}

@Model
final class Payment {
    
    var id: UUID = UUID()
    var method: String
    var value: Decimal
    var competence: Date?
    
    var transaction: Transaction?
    
    init(method: String, value: Decimal, competence: Date?, transaction: Transaction? = nil) {
        self.method = method
        self.value = value
        self.competence = competence
        self.transaction = transaction
    }
}

@Model
final class EarningCategory {
    
    var id: UUID = UUID()
    var name: String
    var emoji: String?
    
    var transaction: Transaction?
    
    init(name: String, emoji: String?, transaction: Transaction? = nil) {
        self.name = name
        self.emoji = emoji
        self.transaction = transaction
    }
}

@Model
final class ExpenseCategory {
    
    var id: UUID = UUID()
    var name: String
    var emoji: String?
    
    var transaction: Transaction?
    
    init(name: String, emoji: String?, transaction: Transaction? = nil) {
        self.name = name
        self.emoji = emoji
        self.transaction = transaction
    }
}
