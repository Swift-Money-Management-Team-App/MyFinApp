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
    // Entrada de Dados
    @State var bankAccountName: String = ""
    @State var accountName : String = ""
    @State var closeDay : Int = 0
    // Dados para visualização
    let bankAccount: BankAccount
    @State var isCreditCard: Bool = false
    // Booleans para visualização
    @State var isShowingBankEdit: Bool = false
    @State var presentAddAccountView: Bool = false
    
    
    
    var body: some View {
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
                        Button(action: {  }) {
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
                                cleanInputs()
                                isCreditCard = true
                                presentAddAccountView = true
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
                                cleanInputs()
                                presentAddAccountView = true
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
                    HStack {
                        Text("Contas")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        Spacer()
                        // TODO: Adioncar conta
                        Button(action: {  }) {
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
                    Text("\(bankAccount.name)")
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
                    Text("Voltar")
                }
            }
            ToolbarItem {
                Button(action: { isShowingBankEdit.toggle() }) {
                    Label("Mostrar", systemImage: "pencil")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden)
        .onAppear { self.bankAccountName = self.bankAccount.name }
        .sheet(isPresented: $isShowingBankEdit) {
            FinancialInstitueForm(bankName: self.$bankAccountName, originalName: self.bankAccountName, formState: .read, action: self.setNameBankAccount, deleteAction: {
                self.deleteBankAccount()
                Navigation.navigation.screens.removeLast()
            })
        }
        .sheet(isPresented: $presentAddAccountView) {
            NavigationStack {
                AddAccountView(accountName: $accountName, isCreditCard: $isCreditCard, invoiceClosing: $closeDay, bankAccount: self.bankAccount, modelContext: self.modelContext) {
                    appendAccount()
                }
            }
            .presentationDetents([.medium])
        }
    }
    
}

#Preview {
    BankAccountView(bankAccount: BankAccount(idUser: UUID(), name: "Filipe"))
}
