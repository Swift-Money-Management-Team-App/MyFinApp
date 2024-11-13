import SwiftUI
import SwiftData
import CoreData

struct HomeView: View {
    
    @ObservedObject var homeVM : HomeViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @Query var bankAccounts: [BankAccount]
    
    init(modelContext: ModelContext) {
        self.homeVM = HomeViewModel(modelContext: modelContext)
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Spacer(minLength: 175)
                        Text("Saldos")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        List {
                            ConditionCell(cellName: "Conta Corrente", valueAllAccounts: $homeVM.valueAllCurrentAccounts, hiddenValues: $homeVM.hiddenValues)
                            ConditionCell(cellName: "Cartão de Crédito", valueAllAccounts: $homeVM.valueAllCreditCards, hiddenValues: $homeVM.hiddenValues)
                        }
                        .frame(height: 64 * 2)
                        .scrollDisabled(true)
                        .listStyle(.inset)
                        
                        Text("O que deseja fazer?")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                            OperationCard(type: .addMovement, text: "Adicionar movimentação")
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
                            Button(action: { self.homeVM.isShowingScreenNameBankAccount.toggle() }) {
                                Image(systemName: "plus")
                            }
                            .padding([.top, .trailing])
                        }
                        if(self.homeVM.bankAccounts.isEmpty){
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
                                    NavigationLink(
                                        destination: { BankAccountView(modelContext: homeVM.modelContext, bankAccount: bankAccount) }) {
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
                    .overlay (alignment: .bottomLeading){
                        if (!self.homeVM.isShowingScreenNameUser) {
                            Text("Olá, \(String(describing: self.homeVM.user.first!.name))!")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                        } else {
                            Text("Bem-vindo!")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                        }
                    }
                    .frame(height: 175)
            }
            .ignoresSafeArea()
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: { self.homeVM.toggleHiddenValues() }) {
                        if self.homeVM.hiddenValues {
                            Label("Mostrar", systemImage: "eye.slash")
                        } else {
                            Label("Esconder", systemImage: "eye")
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    NavigationLink(destination: SettingsView(settingsVM: settingsVM)) {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .toolbarBackground(.hidden)
        }
        .sheet(isPresented: self.$homeVM.isShowingScreenNameUser, content: {
            UserForm(name: self.$homeVM.personName, formState: .create, action: self.homeVM.appendUser)
        .sheet(isPresented: self.$homeVM.isShowingScreenNameUser, content: {
            UserForm(name: self.$homeVM.personName, formState: .create, action: self.homeVM.appendUser)
        })
        .sheet(isPresented: self.$homeVM.isShowingScreenNameBankAccount, content: {
            FinancialInstitueForm(bankName: self.$homeVM.bankAccountName, originalName: self.homeVM.bankAccountName, formState: .create, action: self.homeVM.appendBankAccount)
        })
        .alert("Tem certeza de que deseja descartar esta nova Instituição Financeira?", isPresented: $homeVM.isShowingBankCancellationAlert) {
            Button("Descartar Alterações", role: .cancel) {  }
            Button("Continuar Editando", role: .destructive) {  }
                .tint(.blue)
}

#Preview {
    HomeView(modelContext: try! ModelContainer(for: User.self, BankAccount.self).mainContext)
}
