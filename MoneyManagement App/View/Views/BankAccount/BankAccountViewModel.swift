import Foundation
import SwiftData

@Observable
class BankAccountViewModel: ObservableObject {
    
    // SwiftData
    let modelContext: ModelContext
    var bankAccount: BankAccount
    //var creditCards: [Account] = []
    //var accounts: [Account] = []
    // Entrada de Dados
    var bankAccountName: String = ""
    var accountName : String = ""
    var isCreditCard : Bool = false
    var closeDay : Int = 0    
    // Booleans para visualização
    var isShowingBankEdit: Bool = false
    var presentAddAccountView = false
    
    init(modelContext: ModelContext, bankAccount: BankAccount) {
        self.modelContext = modelContext
        self.bankAccount = bankAccount
        self.bankAccountName = self.bankAccount.name
    }
    
    /*
    
    func fetchCreditCards() {
        do {
            self.creditCards = try modelContext.fetch(FetchDescriptor<Account>(sortBy: [.init(\.name)]))
        } catch {
            print("Deu ruim 1")
        }
    }
    
    func fetchAccounts() {
        do {
            let accountsFetched = try modelContext.fetch(FetchDescriptor<Account>(sortBy: [.init(\.name)]))
            accounts.removeAll()
            accounts.append(contentsOf: accountsFetched)
        } catch {
            print("Deu ruim 1")
        }
    }
    */
     
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
    
    func appendAccount () {
        let account = Account(idUser: self.bankAccount.idUser, name: self.accountName)
                
        self.modelContext.insert(account)
        
        if self.isCreditCard {
            account.isCreditCard = true
            account.closeDay = closeDay
        }
        
        do {
            try self.modelContext.save()
        } catch {
            print("Deu ruim")
        }
        
        cleanInputs()
        
        presentAddAccountView = false
    }
    
    func cleanInputs () {
        self.bankAccountName = ""
        self.isCreditCard = false
        self.closeDay = 1
    }
}
