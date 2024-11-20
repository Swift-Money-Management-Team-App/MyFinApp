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
        
        ZStack (alignment: .top) {
            ScrollView {
                VStack (alignment: .leading) {
                    Spacer(minLength: 175)
                    Text("Saldos")
                        .foregroundStyle(.darkPink)
                        .fontWeight(.semibold)
                        .padding([.top, .leading])
                    List {
                        ConditionCell(cellName: "Conta Corrente", valueAllAccounts: $valueAllCurrentAccounts, hiddenValues: $hiddenValues)
                        ConditionCell(cellName: "Cartão de Crédito", valueAllAccounts: $valueAllCreditCards, hiddenValues: $hiddenValues)
                    }
                    .frame(height: 64 * 2)
                    .scrollDisabled(true)
                    .listStyle(.inset)
                    
                    Text("O que deseja fazer?")
                        .foregroundStyle(.darkPink)
                        .fontWeight(.semibold)
                        .padding([.top, .leading])
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                        NavigationLink(value: NavigationScreen.movement(account: nil, bankAccount: nil)) {
                            OperationCard(type: .addMovement, text: "Adicionar movimentação")
                        }
                        OperationCard(type: .movementCategory, text: "Categoria de transação")
                        OperationCard(type: .paymentMethod, text: "Método de pagamento")
                        OperationCard(type: .generalHistory, text: "Histórico Geral")
                    }
                    .padding(.horizontal)
                    HStack{
                        Text("Instituições Financeiras")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        Spacer()
                        Button(action: { self.isShowingScreenNameBankAccount.toggle() }) {
                            Image(systemName: "plus")
                        }
                        .padding([.top, .trailing])
                    }
                    if(self.bankAccounts.isEmpty){
                        HStack (alignment: .center) {
                            Text("Não possui contas bancária")
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
        .navigationTitle(!self.isShowingScreenNameUser ? "Olá, \(self.user.first?.name ?? "...")!" : "Bem-vindo!")
        .navigationBarTitleDisplayMode(.large)
        .toolbar{
            ToolbarItem(placement: .confirmationAction) {
                Button(action: { self.toggleHiddenValues() }) {
                    if self.hiddenValues {
                        Label("Mostrar", systemImage: "eye.slash")
                    } else {
                        Label("Esconder", systemImage: "eye")
                    }
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                NavigationLink(value: NavigationScreen.settings) {
                    Image(systemName: "gearshape")
                }
            }
        }
        .onAppear { self.isShowingScreenNameUser = self.user.isEmpty ? true : false }
        .toolbarBackground(.hidden)
        .sheet(isPresented: self.$isShowingScreenNameUser, content: {
            UserForm(name: self.$personName, formState: .create, action: self.appendUser)
        })
        .sheet(isPresented: self.$isShowingScreenNameBankAccount, content: {
            FinancialInstitueForm(bankName: self.$bankAccountName, originalName: self.bankAccountName, formState: .create, action: self.appendBankAccount)
        })
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [User.self, BankAccount.self, EarningCategory.self, ExpenseCategory.self, Method.self])
}
