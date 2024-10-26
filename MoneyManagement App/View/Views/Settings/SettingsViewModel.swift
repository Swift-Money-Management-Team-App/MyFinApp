import Foundation

class SettingsViewModel: ObservableObject {
    
    // STATE VARIABLES
    @Published var isShowOnboarding: Bool = false
    
    // CONSTANTS
    private let SHARED_LINK = URL(string: "https://apps.apple.com/us/app/MoneyManagementApp/id11111111")!

}



// GETTERS
extension SettingsViewModel {
    
    
    func getSharedLink() -> URL {
        return SHARED_LINK
    }
}
