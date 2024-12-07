import SwiftUI
import SwiftData

struct AccountView: View {
    
    // SwiftData
    @Query var movements: [Movement]
    @Query var payments: [Payment]
    @Query var expenseCategories: [ExpenseCategory]
    @Query var earningCategories: [EarningCategory]
    // Entrada de Dados
    var account: Account
    // Dados para visualização
    @State var movementsToRead: [Movement] = []
    // Booleans para visualização
    // TODO: ADICIONAR VARIÁVEL PARA MOVIMENTAÇÃO
    // Booleans para visualização
    @State var isShowAccountForm: Bool = false
    
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { layout in
                ScrollView {
                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.brightGold)
                            .overlay (alignment: .bottomLeading){
                                Text(self.account.name)
                                    .font(.largeTitle)
                                    .bold()
                                    .padding()
                            }
                            .frame(height: 175)
                        
                        Text("Total")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        List {
                            ValueRow(value: self.account.total)
                        }
                        .frame(height: 42)
                        .scrollDisabled(true)
                        .listStyle(.inset)
                        
                        Text(LocalizedStringKey.whatToDo.label)
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                            // TODO: NAVEGAR PARA A TELA DE ABRIR UM MOVIMENTO
                            OperationCard(type: .addMovement, text: LocalizedStringKey.addTransaction.label)
                            // TODO: NAVEGAR PARA O HISTÓRICO NO CONTEXTO DE CONTA
                            OperationCard(type: .generalHistory, text: "Histórico")
                        }
                        .padding(.horizontal)
                        
                        Text("Histórico do Mês")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        
                        List {
                            ForEach(self.movementsToRead) { movement in
                                let payments = self.payments.filter({ payment in payment.idMovement == movement.id })
                                let total: Double = self.totalMovements(earned: movement.earningCategory != nil, payments: payments)
                                let time: Date = self.oldTime(payments: payments)
                                
                                BankStatementRow(
                                    description: movement.transactionDescription ?? "Sem descrição",
                                    value: total,
                                    icon: movement.expenseCategory != nil ? self.expenseCategories.filter({ category in category.id == movement.expenseCategory }).first!.emoji : self.earningCategories.filter({ category in category.id == movement.earningCategory }).first!.emoji,
                                    day: movement.date.formatted(.dateTime.day()),
                                    time: time.formatted(.dateTime
                                        .hour(.twoDigits(amPM: .omitted))
                                        .minute(.twoDigits)
                                    )
                                )
                            }
                        }
                        .frame(height: layout.size.height - 625)
                        .listStyle(.grouped)
                        
//                        List{
//                            // TODO: FAZER A QUERY PARA CALCULAR A DIFERENÇA ENTRE OS GASTOS E GANHOS DO MÊS ANTERIOR (DO DIA 1 ATE O ULTIMO DIA DO MES)
//                            LastMonthBalanceRow(value: 40.00)
//                        }
//                        .frame(height: 42)
//                        .scrollDisabled(true)
//                        .listStyle(.inset)
//                        .padding(.top, 42)
                    }
                }
            }
            .background(Color.background)
        }
        .onAppear {
            self.allMovements()
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem {
                Button(action: { self.isShowAccountForm = true }) {
                    Label("Editar Conta", systemImage: "pencil")
                }
            }
        }
        .toolbarBackground(.hidden)
        .sheet(isPresented: self.$isShowAccountForm) {
            AccountForm(account: self.account, bankAccount: nil, actionDelete: { Navigation.navigation.screens.removeLast() }, formState: .read)
        }
    }
}

#Preview {
    NavigationStack {
        AccountView(account: .init(idBankAccount: UUID(), name: "Safade"))
    }
}
