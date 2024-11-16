import Foundation
import SwiftData

@Observable
class HomeViewModel : ObservableObject {
    
    // SwiftData
    let modelContext: ModelContext
    var user: [User] = []
    var bankAccounts: [BankAccount] = []
    // Entrada de Dados
    var personName: String = ""
    var bankAccountName: String = ""
    // Dados para visualização
    var hiddenValues: Bool = Storage.share.hiddenValues
    var valueAllCurrentAccounts: Double = 0
    var valueAllCreditCards: Double = 0
    // Booleans para visualização
    var isShowingScreenNameUser: Bool = false
    var isShowingScreenNameBankAccount: Bool = false
    var isShowingBankCancellationAlert: Bool = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.fetchUser()
        self.fetchBankAccounts()
        self.isShowingScreenNameUser = self.user.isEmpty ? true : false
    }
    
    func fetchUser() {
        do {
            self.user = try modelContext.fetch(FetchDescriptor<User>(sortBy: [.init(\.name)]))
        } catch {
            print("Deu ruim 1")
        }
    }
    
    func fetchBankAccounts() {
        do {
            self.bankAccounts = try modelContext.fetch(FetchDescriptor<BankAccount>(sortBy: [.init(\.name)]))
        } catch {
            print("Deu ruim 1")
        }
    }
    
    func appendUser() {
        self.modelContext.insert(User(name: self.personName))
        do {
            try modelContext.save()
        } catch {
            print("Deu ruim 2")
        }
        self.fetchUser()
        self.isShowingScreenNameUser = false
    }
    
    func appendBankAccount() {
        self.modelContext.insert(BankAccount(idUser: self.user.first!.id, name: self.bankAccountName))
        do {
            try modelContext.save()
        } catch {
            print("Deu ruim 2")
        }
        self.fetchBankAccounts()
        self.isShowingScreenNameBankAccount = false
    }
    
    func toggleHiddenValues() {
        self.hiddenValues.toggle()
        Storage.share.hiddenValues.toggle()
    }
    
}
