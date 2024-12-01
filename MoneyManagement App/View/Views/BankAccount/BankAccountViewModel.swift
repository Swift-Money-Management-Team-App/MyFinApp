import Foundation
import SwiftData

extension BankAccountView {
    
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
    
    func fakeAccounts() {
        self.modelContext.insert(Account(idUser: self.bankAccount.id, name: "Safade"))
        self.modelContext.insert(Account(idUser: self.bankAccount.id, name: "Safade Credit", isCreditCard: true))
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
        
    }
    
    func cleanInputs () {
        self.bankAccountName = ""
        self.isCreditCard = false
        self.closeDay = 1
    }
    
}
