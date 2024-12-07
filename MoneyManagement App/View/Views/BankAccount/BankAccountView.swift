import SwiftUI
import SwiftData

struct BankAccountView: View {
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<Account> { account in
        account.isCreditCard == true
    }, sort: \Account.name) var creditCards: [Account] = []
    @Query(filter: #Predicate<Account> { account in
        account.isCreditCard == false
    }, sort: \Account.name) var accounts: [Account] = []
    
    // Input Data
    @State var bankAccountName: String = ""
    @State var accountName: String = ""
    @State var closeDay: Int = 0
    
    // Visualization Data
    @State var bankAccount: BankAccount
    @State var isCreditCard: Bool = false
    
    // View States
    @State var isShowingBankEdit: Bool = false
    @State var isShowingCreateAccount: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer(minLength: 175)
                    
                    Text(LocalizedStringKey.totalBalance.label)
                        .foregroundStyle(.darkPink)
                        .fontWeight(.semibold)
                        .padding([.top, .leading])
                    
                    List {
                        ConditionCell(
                            cellName: LocalizedStringKey.accounts.label,
                            valueAllAccounts: self.$bankAccount.total,
                            hiddenValues: .constant(false)
                        )
                    }
                    .frame(height: 64)
                    .scrollDisabled(true)
                    .listStyle(.inset)
                    
                    Text(LocalizedStringKey.whatToDo.label)
                        .foregroundStyle(.darkPink)
                        .fontWeight(.semibold)
                        .padding([.top, .leading])
                    
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                        OperationCard(type: .addMovement, text: LocalizedStringKey.addTransaction.label)
                        OperationCard(type: .generalHistory, text: LocalizedStringKey.bankAccountHistory.label)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text(LocalizedStringKey.creditCard.label)
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        Spacer()
                        Button(action: {
                            self.isCreditCard = true
                            self.isShowingCreateAccount.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                        .padding([.top, .trailing])
                    }
                    
                    if creditCards.isEmpty {
                        HStack(alignment: .center) {
                            Text(LocalizedStringKey.noCreditCards.label)
                                .font(.title3)
                                .bold()
                                .padding(10)
                        }
                        .fixedSize()
                        .frame(maxWidth: .infinity, minHeight: 130)
                    } else {
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                            ForEach(creditCards.filter {account in account.idBankAccount == bankAccount.id }) { account in
                                NavigationLink(value: NavigationScreen.account(account: account)) {
                                    BankAccountViewAccount(account: account)
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text(LocalizedStringKey.accounts.label)
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        Spacer()
                        // TODO: Adioncar conta
                        Button(action: {
                            self.isCreditCard = false
                            self.isShowingCreateAccount.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                        .padding([.top, .trailing])
                    }
                    
                    if accounts.isEmpty {
                        HStack(alignment: .center) {
                            Text(LocalizedStringKey.noAccounts.label)
                                .font(.title3)
                                .bold()
                                .padding(10)
                        }
                        .fixedSize()
                        .frame(maxWidth: .infinity, minHeight: 130)
                    } else {
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                            ForEach(accounts.filter {account in account.idBankAccount == bankAccount.id }) { account in
                                NavigationLink(value: NavigationScreen.account(account: account)) {
                                    BankAccountViewAccount(account: account)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            .background(Color.background)
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.brightGold)
                .overlay(alignment: .bottomLeading) {
                    Text(bankAccount.name)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                }
                .frame(height: 175)
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: { Navigation.navigation.screens.removeLast() }) {
                    Text(LocalizedStringKey.back.button)
                }
            }
            ToolbarItem {
                Button(action: { isShowingBankEdit.toggle() }) {
                    Label(LocalizedStringKey.edit.button, systemImage: "pencil")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden)
        .onAppear { self.bankAccountName = self.bankAccount.name }
        .sheet(isPresented: $isShowingBankEdit) {
            FinancialInstitueForm(
                bankName: self.$bankAccountName,
                originalName: self.bankAccountName,
                formState: .read,
                action: self.setNameBankAccount,
                deleteAction: {
                    self.deleteBankAccount()
                    Navigation.navigation.screens.removeLast()
                }
            )
        }
        .sheet(isPresented: $isShowingCreateAccount) {
            AccountForm(bankAccount: self.bankAccount, isCreditCard: self.isCreditCard, actionDelete: {}, formState: .create)
        }
    }
}

#Preview {
    BankAccountView(bankAccount: BankAccount(idUser: UUID(), name: "Filipe"))
}
