import SwiftUI
import SwiftData

@main
struct MoneyManagement_AppApp: App {
    @AppStorage("firstLaunchApplication") var  firstLaunchApplication: Bool = Storage.share.firstLaunchApplication
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            if firstLaunchApplication {
                OnboardingView(isFirstLaunch: $firstLaunchApplication)
            } else {
                HomeView(modelContext: container.mainContext)
                    .modelContainer(container)
            }
        }
    }
    
    init() {
        do {
            container = try ModelContainer(for: User.self, BankAccount.self)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
    
}
