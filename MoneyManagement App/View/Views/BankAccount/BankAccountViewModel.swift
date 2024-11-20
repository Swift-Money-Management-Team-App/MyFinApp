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
    
}
