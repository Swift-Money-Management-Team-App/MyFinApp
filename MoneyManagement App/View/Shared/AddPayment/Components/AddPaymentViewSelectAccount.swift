import SwiftUI
import SwiftData

struct AddPaymentViewSelectAccount: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Query var accounts: [Account]
    // Entrada de Dados
    @Binding var selectedAccount: Account?
    // Dados para visualização
    
    // Booleans para visualização
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(accounts) { account in
                        Button(action: { self.selectedAccount = account }) {
                            HStack{
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
                    Button("Voltar") { dismiss() }
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Contas")
                        
                    }
                }
            }
        }
    }
    
}

#Preview {
    AddPaymentViewSelectAccount(selectedAccount: .constant(.init(idUser: UUID(), name: "Safade")))
}
