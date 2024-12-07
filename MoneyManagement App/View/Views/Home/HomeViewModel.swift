import Foundation
import SwiftUI
import SwiftData

extension HomeView {

    func appendUser() {
        repeat { self.modelContext.insert(User(name: self.personName)) } while self.save()
        Storage.share.userName = self.personName

        self.isShowingScreenNameUser = false
        
        // Categorias sendo adicionada
        for category in earningCategoryStandard {
            repeat { self.modelContext.insert(EarningCategory(idUser: self.user.first!.id, emoji: category.emoji, name: category.name)) } while self.save()
        }
        for category in expenseCategoryStandard {
            repeat { self.modelContext.insert(ExpenseCategory(idUser: self.user.first!.id, emoji: category.emoji, name: category.name)) } while self.save()
        }
        for category in methodStandard {
            repeat { self.modelContext.insert(Method(idUser: self.user.first!.id, emoji: category.emoji, name: category.name)) } while self.save()
        }
    }
    
    func appendBankAccount() {
        repeat { self.modelContext.insert(BankAccount(idUser: self.user.first!.id, name: self.bankAccountName)) } while self.save()
        self.isShowingScreenNameBankAccount = false
    }
    
    func toggleHiddenValues() {
        self.hiddenValues.toggle()
        Storage.share.hiddenValues.toggle()
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
    
    func totalValues() {
        self.valueAllCreditCards = 0
        self.valueAllCurrentAccounts = 0
        for payment in self.payments {
            if payment.competence != nil {
                if movements.filter({ movement in movement.id == payment.idMovement }).first!.earningCategory != nil {
                    self.valueAllCreditCards += payment.value
                } else {
                    self.valueAllCreditCards -= payment.value
                }
            } else {
                if movements.filter({ movement in movement.id == payment.idMovement }).first!.earningCategory != nil {
                    self.valueAllCurrentAccounts += payment.value
                } else {
                    self.valueAllCurrentAccounts -= payment.value
                }
            }
        }
        
    }
    
}
