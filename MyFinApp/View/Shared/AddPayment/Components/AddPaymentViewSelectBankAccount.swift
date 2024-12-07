import SwiftUI
import SwiftData

struct AddPaymentViewSelectBankAccount: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Query var bankAccounts: [BankAccount]
    @Query var accounts: [Account]
    // Entrada de Dados
    @Binding var selectedBankAccount: BankAccount?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bankAccounts.filter { bankAccount in !(self.accounts.filter({ account in account.idBankAccount == bankAccount.id }).isEmpty) }) { bankAccount in
                    Button(action: { self.selectedBankAccount = bankAccount }) {
                        HStack {
                            Text(bankAccount.name)
                                .foregroundStyle(.black)
                            Spacer()
                            if self.selectedBankAccount == bankAccount {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.blue)
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
                        Text(LocalizedStringKey.financialInstituteTitle.label)
                    }
                }
            }
        }
    }
    
}

#Preview {
    AddPaymentViewSelectBankAccount(selectedBankAccount: .constant(.init(idUser: UUID(), name: "Safade")))
}
