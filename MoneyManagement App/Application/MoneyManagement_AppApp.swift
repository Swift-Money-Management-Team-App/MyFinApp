import SwiftUI

@main
struct MoneyManagement_AppApp: App {
    
    let settingsVM = SettingsViewModel()
    
    let persistenceController = PersistenceController.shared

    @AppStorage("hasLaunchedBefore") private var firstLaunchApplication: Bool = true
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                withAnimation {
                                    showSplash = false
                                }
                            }
                        }
                        .transition(.opacity)
                } else {
                    if firstLaunchApplication {
                        OnboardingView(isFirstLaunch: $firstLaunchApplication)
                            .transition(.opacity)
                    } else {
                        ContentView()
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                            .environmentObject(self.settingsVM)
                            .transition(.opacity)
                    }
                }
            }
        }
    }
}
