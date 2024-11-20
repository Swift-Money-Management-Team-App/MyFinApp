import SwiftUI
import SwiftData

struct AddPaymentView: View {
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var accounts: [Account]
    @Query var bankAccounts: [BankAccount]
    @Query var methods: [Method]
    // Entrada de Dados
    @State var account: Account? = nil
    @State var bankAccount: BankAccount? = nil
    @State var method: Method? = nil
    @State var value: Double = 0.00
    @State var time: Date = .now
    @State var payment: Payment? = nil
    // Dados para visualização
    let type: AddPaymentType
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyCode = "BRL"
        formatter.currencySymbol = "R$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 2
        formatter.maximumIntegerDigits = 13
        formatter.usesGroupingSeparator = true
        return formatter
    }()
    // Booleans para visualização
    @State var alertCancel: Bool = false
    
    var body: some View {
        List {
            Section {
                Label {} icon: {
                    HStack {
                        Image(systemName: "wallet.bifold")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(20)
                }
                .labelStyle(.iconOnly)
                NavigationLink(destination: {
                    AddPaymentViewSelectBankAccount(selectedBankAccount: .constant(.init(idUser: UUID(), name: "Safade")))
                }) {
                    HStack {
                        Text("Institução Financeira")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Banco")
                            .foregroundStyle(.gray)
                    }
                }
                NavigationLink(destination: {
                    AddPaymentViewSelectAccount(selectedAccount: .constant(.init(idUser: UUID(), name: "Safade")))
                }) {
                    HStack {
                        Text("Conta")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Conta")
                            .foregroundStyle(.gray)
                    }
                }
            }
            Section {
                NavigationLink(destination: {
                    AddPaymentViewSelectMethod(selectedMethod: .constant(.init(idUser: UUID(), emoji: "Safade", name: "Safade")))
                        .modelContainer(for: Method.self)
                }) {
                    HStack {
                        Text("Método de pagamento")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Categoria")
                            .foregroundStyle(.gray)
                    }
                }
                Label(title: {
                    HStack {
                        Text("Valor")
                        Spacer()
                        HStack {
                            Text("R$")
                            CurrencyTextField(numberFormatter: currencyFormatter, value: $value)
                        }
                        .fixedSize()
                    }
                    
                }, icon: {})
                .labelStyle(.titleOnly)
                Label(title: {
                    DatePicker("Horário", selection: $time, displayedComponents: [.hourAndMinute])
                }, icon: {})
                .labelStyle(.titleOnly)
            }
        }
        .listStyle(.grouped)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: { Navigation.navigation.screens.removeLast() }) {
                    Text("Cancelar")
                }
            }
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(self.type == .create ? "Adicionar pagamento": "Editar pagamento")
                    
                }
            }
            ToolbarItem {
                Button(action: {}) {
                    Text(self.type == .create ? "Adicionar": "Editar")
                }
            }
        }
        .background(Color.background)
        .navigationBarBackButtonHidden(true)
        .alert("Tem certeza de que deseja descartar estas alterações?", isPresented: $alertCancel) {
            Button("Continuar Editando", role: .cancel) {}
                .tint(.blue)
            Button("Descartar Alterações", role: .destructive) {}
        }
    }
    
}

#Preview {
    AddPaymentView(type: .create)
}
