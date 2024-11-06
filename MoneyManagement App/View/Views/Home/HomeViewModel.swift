import Foundation
import SwiftData

@Observable
class HomeViewModel : ObservableObject {
    
    let modelContenxt: ModelContext
    var personName: String = ""
    var user: [User] = []
    var bankAccountName: String = ""
    var bankAccounts: [BankAccount] = []
    var valueAllCurrentAccounts: Double = 0
    var valueAllCreditCards: Double = 0
    var isShowingScreenNameUser: Bool = false
    var isShowingScreenNameBankAccount: Bool = false
    var hiddenValues: Bool = Storage.share.hiddenValues
    
    init(modelContenxt: ModelContext) {
        self.modelContenxt = modelContenxt
        self.fetchUser()
        self.fetchBankAccounts()
        self.isShowingScreenNameUser = self.user.isEmpty ? true : false
    }
    
    func fetchUser() {
        do {
            self.user = try modelContenxt.fetch(FetchDescriptor<User>(sortBy: [.init(\.name)]))
        } catch {
            print("Deu ruim 1")
        }
    }
    
    func fetchBankAccounts() {
        do {
            self.bankAccounts = try modelContenxt.fetch(FetchDescriptor<BankAccount>(sortBy: [.init(\.name)]))
        } catch {
            print("Deu ruim 1")
        }
    }
    
//    TODO: AQUI ESTÁ DANDO PROBLEMAS POIS ESTÁ SÓ APPEND USUÁRIO E NÃO ADICIONANDO SOMENTE UM USUÁRUIO
    func appendUser() {
        self.modelContenxt.insert(User(name: self.personName))
        do {
            try modelContenxt.save()
        } catch {
            print("Deu ruim 2")
        }
        self.fetchUser()
        for user in user {
            print(user.name)
        }
        self.isShowingScreenNameUser = false
    }
    
    func appendBankAccount() {
        self.modelContenxt.insert(BankAccount(idUser: self.user.first!.id, name: self.bankAccountName))
        do {
            try modelContenxt.save()
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
