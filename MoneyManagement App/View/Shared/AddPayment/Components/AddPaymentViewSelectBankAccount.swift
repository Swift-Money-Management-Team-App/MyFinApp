import SwiftUI
import SwiftData

struct AddPaymentViewSelectBankAccount: View {
    
    @Binding var selectedBankAccount: BankAccount
    @Query var bankAccounts: [BankAccount]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(bankAccounts) { bankAccount in
                    Button(action: { }) {
                        HStack{
                            Text(bankAccount.name)
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundStyle(.blue)
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {}) {
                        Text("Voltar")
                    }
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Instituição Financeira")
                        
                    }
                }
            }
            .background(Color.background)
        }
    }
    
}

#Preview {
    AddPaymentViewSelectBankAccount(selectedBankAccount: .constant(.init(idUser: UUID(), name: "Safade")))
}
