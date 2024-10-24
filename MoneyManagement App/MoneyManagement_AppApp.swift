import SwiftUI

@main
struct MoneyManagement_AppApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("firstLaunchApplication") var  firstLaunchApplication: Bool = Storage.share.firstLaunchApplication
    
    var body: some Scene {
        WindowGroup {
            if firstLaunchApplication {
                OnboardingView(isFirstLaunch: $firstLaunchApplication)
            } else {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
