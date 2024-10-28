import Foundation

class SettingsViewModel: ObservableObject {
    
    // STATE VARIABLES
    @Published var isShowOnboarding: Bool = false
    
    // CONSTANTS
    private let SHARED_LINK = URL(string: "https://apps.apple.com/us/app/MoneyManagementApp/id11111111")!
    private let PRIVACY_POLICY = URL(string: "https://www.google.com.br")!
    private let USE_TERMS = URL(string: "https://www.google.com.br")!
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
