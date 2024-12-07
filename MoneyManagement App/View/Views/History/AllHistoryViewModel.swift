import Foundation

extension AllHistoryView {
    
    func totalBankAccounts() {
        self.total = 0
        for bankAccount in self.bankAccounts {
            self.total += bankAccount.total
        }
    }
    
}
