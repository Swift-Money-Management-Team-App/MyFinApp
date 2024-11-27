import SwiftUI
import SwiftData

#if DEBUG
@main
struct MoneyManagement_AppApp: App {
    
    @ObservedObject var navigation: Navigation = .navigation
    @State var firstLaunchApplication: Bool = Storage.share.firstLaunchApplication
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            if firstLaunchApplication {
                OnboardingView(isFirstLaunch: $firstLaunchApplication)
                    .transition(.opacity)
            } else {
                NavigationStack(path: $navigation.screens) {
                    HomeView()
                        .transition(.opacity)
                        .navigationDestination(for: NavigationScreen.self) { screen in
                            switch(screen) {
                            case .settings:
                                SettingsView()
                            case .account(account: let account):
                                Text("Conta")
                            case .bankAccount(bankAccount: let bankAccount):
                                BankAccountView(bankAccount: bankAccount)
                            case .movement(account: let account, bankAccount: let bankAccount):
                                AddMovementView(account: account, bankAccount: bankAccount)
                            case .privacyPolicy:
                                PrivacyPolicy()
                            case .terms:
                                TermsView()
                            case .aboutUs:
                                AboutUs()
                            }
                        }
                }
                .modelContainer(for: [Account.self, BankAccount.self, EarningCategory.self, ExpenseCategory.self, Movement.self, Method.self, Payment.self, User.self])
            }
        }
    }
}

#else
@main
struct MoneyManagement_AppApp: App {
    
    @ObservedObject var navigation: Navigation = .navigation
    @State var firstLaunchApplication: Bool = Storage.share.firstLaunchApplication
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
                        NavigationStack(path: $navigation.screens) {
                            HomeView()
                                .transition(.opacity)
                                .navigationDestination(for: NavigationScreen.self) { screen in
                                    switch(screen) {
                                    case .settings:
                                        SettingsView()
                                    case .account(account: let account):
                                        Text("Conta")
                                    case .bankAccount(bankAccount: let bankAccount):
                                        BankAccountView(bankAccount: bankAccount)
                                    case .movement(account: let account, bankAccount: let bankAccount):
                                        AddMovementView(account: account, bankAccount: bankAccount)
                                    case .privacyPolicy:
                                        PrivacyPolicy()
                                    case .terms:
                                        TermsView()
                                    case .aboutUs:
                                        AboutUs()
                                    }
                                }
                        }
                        .modelContainer(for: [Account.self, BankAccount.self, EarningCategory.self, ExpenseCategory.self, Movement.self, Method.self, Payment.self, User.self])
                    }
                }
            }
        }
    }
}
#endif
