import SwiftUI
import SwiftData

struct AddPaymentViewSelectAccount: View {
    
    @Binding var selectedAccount: Account
    @Query var accounts: [Account]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(accounts) { account in
                        Button(action: { }) {
                            HStack{
                                Text(account.name)
                                    .foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.blue)
                            }
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
                        Text("Contas")
                        
                    }
                }
            }
            .background(Color.background)
        }
    }
    
}

#Preview {
    AddPaymentViewSelectAccount(selectedAccount: .constant(.init(idUser: UUID(), name: "Safade")))
}
