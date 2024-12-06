import SwiftUI
import SwiftData

struct AddPaymentViewSelectAccount: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Query var accounts: [Account]
    // Entrada de Dados
    @Binding var selectedAccount: Account?
    // Dados para visualização
    @Binding var bankAccount: BankAccount?
    // Booleans para visualização
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(bankAccount != nil ? accounts.filter({ $0.idBankAccount == self.bankAccount?.id }) : accounts) { account in
                        Button(action: { self.selectedAccount = account }) {
                            HStack {
                                Text(account.name)
                                    .foregroundStyle(.black)
                                Spacer()
                                if self.selectedAccount == account {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(LocalizedStringKey.back.button) { dismiss() }
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(LocalizedStringKey.accounts.label)
                    }
                }
            }
        }
    }
}

#Preview {
    AddPaymentViewSelectAccount(selectedAccount: .constant(.init(idBankAccount: UUID(), name: "Safade")), bankAccount: .constant(nil))
}
