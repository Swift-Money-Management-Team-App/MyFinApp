import SwiftUI
import SwiftData

struct AccountView: View {
    
    var account: Account
    var movement: Movement
    // TODO: ADICIONAR VARIÁVEL PARA MOVIMENTAÇÃO
    
    // Booleans para visualização
    @State var isShowAccountForm: Bool = false
    
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.brightGold)
                        .overlay (alignment: .bottomLeading){
                            // TODO: REMOVER `Conta Corrente` e adicionar a variável modular
                            Text(self.account.name)
                                .font(.largeTitle)
                                .bold()
                                .padding()
                        }
                        .frame(height: 175)
                    
                    // TOTAL
                    Text("Total")
                        .foregroundStyle(.darkPink)
                        .fontWeight(.semibold)
                        .padding([.top, .leading])
                    List {
                        // TODO: COLOCAR OS VALORES VARIÁVEIS AQUI
                        ValueRow(value: 500.50)
                    }
                    .frame(height: 42)
                    .scrollDisabled(true)
                    .listStyle(.inset)
                    
                    // O QUE DESEJA FAZER
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
                        // TODO: COLOCAR AQUI O HISTÓRICO DA CONTA USANDO FOR EACH
                        // TODO: SE O USUÁRIO CLICAR NA CÉLULA, ELE TEM QUE ABRIR A TELA DE MOVIMENTAÇÃO SOMENTE NO MODO LEITURA.
                        BankStatementRow(description: "Adiantamento de Salário do Mês de Outubro", value: 50.50, icon: "pencil", day: "22", time: "09:41")
                        BankStatementRow(description: "Lanche no Burger King", value: -10.50, icon: "pencil", day: "22", time: "09:41")
                    }
                    .frame(height: 90)
                    .scrollDisabled(true)
                    .listStyle(.inset)
                    
                    List{
                        // TODO: FAZER A QUERY PARA CALCULAR A DIFERENÇA ENTRE OS GASTOS E GANHOS DO MÊS ANTERIOR (DO DIA 1 ATE O ULTIMO DIA DO MES)
                        LastMonthBalanceRow(value: 40.00)
                    }
                    .frame(height: 42)
                    .scrollDisabled(true)
                    .listStyle(.inset)
                    .padding(.top, 42)
                }
            }
            .background(Color.background)
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
            AccountForm(account: self.account,formState: .read)
        }
    }
}

// TODO: DESCOMENTAR PAR MOSTRAR A VIEW
//#Preview {
//    AccountView()
//}
