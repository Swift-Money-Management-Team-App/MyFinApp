import Foundation
import SwiftData

@Observable
class SettingsViewModel: ObservableObject {
    
    // SwiftData
    let modelContext: ModelContext
    var user: [User] = []
    // Entrada de Dados
    var personName: String = ""
    // Dados para visualização
    
    // Booleans para visualização
    var isShowingScreenNameUser: Bool = false
    var isShowingBankCancellationAlert: Bool = false
    var isShowOnboarding: Bool = false
    
    // Constantes
    private let SHARED_LINK = URL(string: "https://apps.apple.com/us/app/MoneyManagementApp/id11111111")!
    private let PRIVACY_POLICY = URL(string: "https://www.google.com.br")! // TODO: UPDATE THIS URL TO PRIVACY POLICY
    private let USE_TERMS = URL(string: "https://www.google.com.br")! // TODO: UPDATE THIS URL TO PRIVACY POLICY
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.fetchUser()
        self.personName = self.user.first?.name ?? ""
    }
    
    func fetchUser() {
        do {
            self.user = try modelContext.fetch(FetchDescriptor<User>(sortBy: [.init(\.name)]))
        } catch {
            print("Deu ruim 1")
        }
    }
    
    func setNameUser() {
        for user in self.user {
            print(user)
        }
        self.user.first?.name = personName
        do {
            try modelContext.save()
        } catch {
            print("Deu ruim 2")
        }
        self.fetchUser()
    }
    
}

// GETTERS
extension SettingsViewModel {
    
    func getSharedLink() -> URL {
        return SHARED_LINK
    }
    
    func getPrivacyPolicy() -> URL {
        return PRIVACY_POLICY
    }
    
    func getUseTerms() -> URL{
        return USE_TERMS
    }
}
