import SwiftUI
import SwiftData

@main
struct MoneyManagement_AppApp: App {
    
    @ObservedObject var navigation: Navigation = .navigation
    @State var firstLaunchApplication: Bool = Storage.share.firstLaunchApplication
    private var userName: String = Storage.share.userName
#if DEBUG
    @State private var showSplash = false
#else
    @State private var showSplash = true
#endif
    @State var isShowingScreenNameUser: Bool = false
    
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
                    NavigationStack(path: $navigation.screens) {
                        HomeView(isShowingScreenNameUser: self.$isShowingScreenNameUser)
                            .transition(.opacity)
                            .navigationDestination(for: NavigationScreen.self) { screen in
                                switch(screen) {
                                case .settings:
                                    SettingsView()
                                case .account(account: let account):
                                    AccountView(account: account)
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
                                case .methods:
                                    MethodCategoryView()
                                case .categories:
                                    CategoriesView()
                                }
                            }
                            .sheet(isPresented: self.$firstLaunchApplication) {
                                OnboardingView(isFirstLaunch: $firstLaunchApplication)
                                    .transition(.opacity)
                                    .onDisappear{
                                        if(firstLaunchApplication == false && userName.isEmpty) {
                                            self.isShowingScreenNameUser = true
                                        }
                                    }
                            }
                    }
                    .modelContainer(for: [Account.self, BankAccount.self, EarningCategory.self, ExpenseCategory.self, Movement.self, Method.self, Payment.self, User.self])
                }
            }
        }
    }
}
