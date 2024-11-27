import SwiftUI
import SwiftData

struct HomeView: View {
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var user: [User]
    @Query var bankAccounts: [BankAccount]
    // Entrada de Dados
    @State var personName: String = ""
    @State var bankAccountName: String = ""
    // Dados para visualização
    @State var hiddenValues: Bool = Storage.share.hiddenValues
    @State var valueAllCurrentAccounts: Double = 0
    @State var valueAllCreditCards: Double = 0
    // Booleans para visualização
    @State var isShowingScreenNameUser: Bool = false
    @State var isShowingScreenNameBankAccount: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer(minLength: 175)
                    Text(LocalizedStringKey.homeBalances.label)
                        .foregroundStyle(.darkPink)
                        .fontWeight(.semibold)
                        .padding([.top, .leading])
                    
                    List {
                        ConditionCell(
                            cellName: LocalizedStringKey.homeCheckingAccount.label,
                            valueAllAccounts: $valueAllCurrentAccounts,
                            hiddenValues: $hiddenValues
                        )
                        ConditionCell(
                            cellName: LocalizedStringKey.homeCreditCard.label,
                            valueAllAccounts: $valueAllCreditCards,
                            hiddenValues: $hiddenValues
                        )
                    }
                    .frame(height: 64 * 2)
                    .scrollDisabled(true)
                    .listStyle(.inset)
                    
                    Text(LocalizedStringKey.homeWhatToDo.label)
                        .foregroundStyle(.darkPink)
                        .fontWeight(.semibold)
                        .padding([.top, .leading])
                    
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                        NavigationLink(value: NavigationScreen.movement(account: nil, bankAccount: nil)) {
                            OperationCard(
                                type: .addMovement,
                                text: LocalizedStringKey.homeAddMovement.label
                            )
                        }
                        OperationCard(type: .movementCategory, text: LocalizedStringKey.homeTransactionCategory.label)
                        OperationCard(type: .paymentMethod, text: LocalizedStringKey.homePaymentMethod.label)
                        OperationCard(type: .generalHistory, text: LocalizedStringKey.homeGeneralHistory.label)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text(LocalizedStringKey.homeFinancialInstitutions.label)
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        Spacer()
                        Button(action: { self.isShowingScreenNameBankAccount.toggle() }) {
                            Image(systemName: "plus")
                        }
                        .padding([.top, .trailing])
                    }
                    
                    if self.bankAccounts.isEmpty {
                        HStack(alignment: .center) {
                            Text(LocalizedStringKey.homeNoBankAccounts.label)
                                .font(.title3)
                                .bold()
                                .padding(10)
                        }
                        .fixedSize()
                        .frame(maxWidth: .infinity, minHeight: 130)
                    } else {
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                            ForEach(self.bankAccounts) { bankAccount in
                                NavigationLink(value: NavigationScreen.bankAccount(bankAccount: bankAccount)) {
                                    HomeViewBankAccount(bankAccount: bankAccount)
                                }
                            }
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .background(Color.background)
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.brightGold)
                .frame(height: 175)
        }
        .ignoresSafeArea()
        .navigationTitle(
            !self.isShowingScreenNameUser
                ? "\(LocalizedStringKey.homeWelcome.label) \(self.user.first?.name ?? "...")!"
                : LocalizedStringKey.homeGreeting.label
        )
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: { self.toggleHiddenValues() }) {
                    if self.hiddenValues {
                        Label(LocalizedStringKey.homeShow.label, systemImage: "eye.slash")
                    } else {
                        Label(LocalizedStringKey.homeHide.label, systemImage: "eye")
                    }
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                NavigationLink(value: NavigationScreen.settings) {
                    Image(systemName: "gearshape")
                }
            }
        }
        .onAppear { self.isShowingScreenNameUser = self.user.isEmpty }
        .toolbarBackground(.hidden)
        .sheet(isPresented: self.$isShowingScreenNameUser) {
            UserForm(name: self.$personName, formState: .create, action: self.appendUser)
        }
        .sheet(isPresented: self.$isShowingScreenNameBankAccount) {
            FinancialInstitueForm(
                bankName: self.$bankAccountName,
                originalName: self.bankAccountName,
                formState: .create,
                action: self.appendBankAccount
            )
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [User.self, BankAccount.self, EarningCategory.self, ExpenseCategory.self, Method.self])
}
