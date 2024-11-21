import Foundation
import SwiftData

extension SettingsView {
    
    // Links
    func getSharedLink() -> URL {
        return URL(string: "https://apps.apple.com/us/app/MoneyManagementApp/id11111111")!
    }
    
    func getPrivacyPolicy() -> URL {
        return URL(string: "https://www.google.com.br")!
    }
    
    func getUseTerms() -> URL{
        return URL(string: "https://www.google.com.br")!
    }
    
    // CRUD
    func setNameUser() {
        self.user.first?.name = personName
        do {
            try modelContext.save()
        } catch {
            print("Deu ruim 2")
        }
    }
}
