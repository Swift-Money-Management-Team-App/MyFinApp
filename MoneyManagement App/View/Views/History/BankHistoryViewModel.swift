import Foundation

extension BankHistoryView {
    
    func totalAccounts() {
        self.total = 0
        for account in self.accounts {
            self.total += account.total
        }
    }
    
}
