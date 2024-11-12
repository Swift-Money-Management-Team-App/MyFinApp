import SwiftUI
import SwiftData

struct BankAccountView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var bankAccountVM: BankAccountViewModel
    
    init(modelContext: ModelContext, bankAccount: BankAccount) {
        self.bankAccountVM = BankAccountViewModel(modelContext: modelContext, bankAccount: bankAccount)
    }
    
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
                            Button(action: {  }) {
                                Image(systemName: "plus")
                            }
                            .padding([.top, .trailing])
                        }
                        if(bankAccountVM.creditCards.isEmpty){
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
                                ForEach(bankAccountVM.accounts) { account in
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
                            Button(action: {  }) {
                                Image(systemName: "plus")
                            }
                            .padding([.top, .trailing])
                        }
                        if(bankAccountVM.accounts.isEmpty){
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
                                ForEach(bankAccountVM.accounts) { account in
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
    }
    
}

#Preview {
    BankAccountView(modelContext: try! ModelContainer(for: User.self, BankAccount.self).mainContext, bankAccount: BankAccount(idUser: UUID(), name: "Safade"))
}

