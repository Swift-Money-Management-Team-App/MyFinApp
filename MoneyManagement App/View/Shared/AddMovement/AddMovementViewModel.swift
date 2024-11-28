import Foundation
import SwiftUI
import SwiftData

extension AddMovementView {
    
    func changeTotal() {
        self.moved = true
        var newTotal: Double = 0
        for payment in payments {
            newTotal += payment.value
        }
        self.total = newTotal
    }
    
    func appendAllPayments() {
        for payment in self.payments {
            modelContext.insert(payment)
            let account = self.accounts.filter({ account in account.id == payment.idAccount }).first!
            if self.earned {
                repeat { account.total += payment.value } while save()
                repeat { self.bankAccounts.filter({ bankAccount in bankAccount.id == account.idBankAccount }).first!.total += payment.value } while save()
            } else {
                repeat { account.total -= payment.value } while save()
                repeat { self.bankAccounts.filter({ bankAccount in bankAccount.id == account.idBankAccount }).first!.total -= payment.value } while save()
            }
        }
    }
    
    func appendMovement() {
        modelContext.insert(self.movement!)
    }
    
    func save() -> Bool {
        do {
            try modelContext.save()
            return false
        } catch {
            print("Deu ruim 2")
            return true
        }
    }
    
}
