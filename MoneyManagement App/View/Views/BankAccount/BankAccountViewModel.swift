import Foundation
import SwiftData

@Observable
class BankAccountViewModel: ObservableObject {
    
    // SwiftData
    let modelContext: ModelContext
    var bankAccount: BankAccount
    var creditCards: [Account] = []
    var accounts: [Account] = []
    // Entrada de Dados
    var bankAccountName: String = ""
    // Dados para visualização
    
    // Booleans para visualização
    var isShowingBankEdit: Bool = false
    
    init(modelContext: ModelContext, bankAccount: BankAccount) {
        self.modelContext = modelContext
        self.bankAccount = bankAccount
        self.bankAccountName = self.bankAccount.name
    }
    
    func fetchCreditCards() {
        do {
            self.creditCards = try modelContext.fetch(FetchDescriptor<Account>(sortBy: [.init(\.name)]))
        } catch {
            print("Deu ruim 1")
        }
    }
    
    func fetchAccounts() {
        do {
            self.accounts = try modelContext.fetch(FetchDescriptor<Account>(sortBy: [.init(\.name)]))
        } catch {
            print("Deu ruim 1")
        }
    }
    
    func setNameBankAccount() {
        self.bankAccount.name = self.bankAccountName
        do {
            try self.modelContext.save()
        } catch {
            print("Deu ruim 1")
        }
    }
    
    func deleteBankAccount() {
        self.modelContext.delete(self.bankAccount)
        do {
            try self.modelContext.save()
        } catch {
            print("Deu ruim 1")
        }
    }
    
}
