import SwiftUI
import SwiftData

struct AddPaymentViewSelectBankAccount: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Query var bankAccounts: [BankAccount]
    // Entrada de Dados
    @Binding var selectedBankAccount: BankAccount?
    // Dados para visualização
    
    // Booleans para visualização
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bankAccounts) { bankAccount in
                    Button(action: { self.selectedBankAccount = bankAccount }) {
                        HStack{
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
                    Button("Voltar") { dismiss() }
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Instituição Financeira")
                        
                    }
                }
            }
        }
    }
    
}

#Preview {
    AddPaymentViewSelectBankAccount(selectedBankAccount: .constant(.init(idUser: UUID(), name: "Safade")))
}
