import SwiftUI
import SwiftData

#if DEBUG
@main
struct MoneyManagement_AppApp: App {
    
    let settingsVM: SettingsViewModel
    
    @State var firstLaunchApplication: Bool = Storage.share.firstLaunchApplication
    @State private var showSplash = true
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: User.self, BankAccount.self)
        } catch {
            fatalError("Failed to create ModelContainer.")
        }
        self.settingsVM = SettingsViewModel(modelContext: container.mainContext)
    }
    
    var body: some Scene {
        WindowGroup {
            if firstLaunchApplication {
                OnboardingView(isFirstLaunch: $firstLaunchApplication)
                    .transition(.opacity)
            } else {
                HomeView(modelContext: container.mainContext)
                    .modelContainer(container)
                    .environmentObject(self.settingsVM)
                    .transition(.opacity)
            }
        }
    }
}

#else
@main
struct MoneyManagement_AppApp: App {
    
    let settingsVM: SettingsViewModel
    
    @State var firstLaunchApplication: Bool = Storage.share.firstLaunchApplication
    @State private var showSplash = true
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: User.self, BankAccount.self)
        } catch {
            fatalError("Failed to create ModelContainer.")
        }
        self.settingsVM = SettingsViewModel(modelContext: container.mainContext)
    }
    
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
                        HomeView(modelContext: container.mainContext)
                            .modelContainer(container)
                            .environmentObject(self.settingsVM)
                            .transition(.opacity)
                    }
                }
            }
        }
    }
}
#endif
