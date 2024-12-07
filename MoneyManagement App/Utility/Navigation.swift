import SwiftUI

final class Navigation: ObservableObject {
    
    static let navigation: Navigation = .init()
    
    @Published var screens: [NavigationScreen] = []
    
    private init() {}
    
}

enum NavigationScreen: Hashable {
    
    case account(account: Account)
    case bankAccount(bankAccount: BankAccount)
    case movement(account: Account? = nil, bankAccount: BankAccount? = nil)
    case settings
    case privacyPolicy
    case terms
    case aboutUs
    case methods
    case categories
    case allHistory
    case bankHistory(bankAccount: BankAccount)
    case accountHistory(account: Account)
}
