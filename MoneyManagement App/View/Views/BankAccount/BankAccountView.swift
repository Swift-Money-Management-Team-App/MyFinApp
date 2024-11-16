import SwiftUI
import SwiftData

struct BankAccountView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var bankAccountVM: BankAccountViewModel
    
    init(modelContext: ModelContext, bankAccount: BankAccount) {
        self.bankAccountVM = BankAccountViewModel(modelContext: modelContext, bankAccount: bankAccount)
    }
    
    @Query(filter: #Predicate<Account> { account in
        account.isCreditCard == true
    }, sort: \Account.name) var creditCards: [Account]
    
    @Query(filter: #Predicate<Account> { account in
        account.isCreditCard == false
    }, sort: \Account.name) var accounts: [Account]
    
    var body: some View {
        NavigationStack{
            ZStack (alignment: .top) {
                ScrollView {
                    VStack (alignment: .leading) {
                        Spacer(minLength: 175)
                        Text("Saldo Total")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        List {
                            ConditionCell(cellName: "Contas", valueAllAccounts: .constant(300.50), hiddenValues: .constant(false))
                        }
                        .frame(height: 64)
                        .scrollDisabled(true)
                        .listStyle(.inset)
                        
                        Text("O que deseja fazer?")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                            OperationCard(type: .addMovement, text: "Adicionar movimentação")
                            OperationCard(type: .generalHistory, text: "Histórico da conta bancária")
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("Cartão de Crédito")
                                .foregroundStyle(.darkPink)
                                .fontWeight(.semibold)
                                .padding([.top, .leading])
                            Spacer()
                            // TODO: Adioncar cartão de crédito
                            Button(action: {
                                bankAccountVM.cleanInputs()
                                bankAccountVM.isCreditCard = true
                                bankAccountVM.presentAddAccountView = true
                            }) {
                                Image(systemName: "plus")
                            }
                            .padding([.top, .trailing])
                        }
                        if(creditCards.isEmpty){
                            HStack (alignment: .center) {
                                Text("Não possui cartões de créditos")
                                    .font(.title3)
                                    .bold()
                                    .padding(10)
                            }
                            .fixedSize()
                            .frame(maxWidth: .infinity, minHeight: 130)
                        } else {
                            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                                ForEach(creditCards) { account in
                                    BankAccountViewAccount(account: account)
                                }
                            }
                        }
                        HStack {
                            Text("Contas")
                                .foregroundStyle(.darkPink)
                                .fontWeight(.semibold)
                                .padding([.top, .leading])
                            Spacer()
                            // TODO: Adioncar conta
                            Button(action: {
                                bankAccountVM.cleanInputs()
                                bankAccountVM.presentAddAccountView = true
                            }) {
                                Image(systemName: "plus")
                            }
                            .padding([.top, .trailing])
                        }
                        if(accounts.isEmpty){
                            HStack (alignment: .center) {
                                Text("Não possui contas")
                                    .font(.title3)
                                    .bold()
                                    .padding(10)
                            }
                            .fixedSize()
                            .frame(maxWidth: .infinity, minHeight: 130)
                        } else {
                            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                                ForEach(accounts) { account in
                                    BankAccountViewAccount(account: account)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
                .background(Color.background)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.brightGold)
                    .overlay (alignment: .bottomLeading){
                        Text("\(bankAccountVM.bankAccount.name)")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                    }
                    .frame(height: 175)
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem {
                    Button(action: { bankAccountVM.isShowingBankEdit.toggle() }) {
                        Label("Mostrar", systemImage: "pencil")
                    }
                }
            }
            .toolbarBackground(.hidden)
        }
        .sheet(isPresented: $bankAccountVM.isShowingBankEdit) {
            FinancialInstitueForm(bankName: self.$bankAccountVM.bankAccountName, originalName: self.bankAccountVM.bankAccountName, formState: .read, action: self.bankAccountVM.setNameBankAccount, deleteAction: {
                self.bankAccountVM.deleteBankAccount()
                self.dismiss()
            })
        }
        .sheet(isPresented: $bankAccountVM.presentAddAccountView) {
            NavigationStack {
                AddAccountView(accountName: $bankAccountVM.accountName, isCreditCard: $bankAccountVM.isCreditCard, invoiceClosing: $bankAccountVM.closeDay, bankAccount: self.bankAccountVM.bankAccount, modelContext: self.bankAccountVM.modelContext) {
                    bankAccountVM.appendAccount()
                }
            }
            .presentationDetents([.medium])
        }
    }
    
}

#Preview {
    BankAccountView(modelContext: try! ModelContainer(for: User.self, BankAccount.self).mainContext, bankAccount: BankAccount(idUser: UUID(), name: "Safade"))
}

