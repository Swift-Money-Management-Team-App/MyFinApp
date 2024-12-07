import SwiftUI

struct BankAccountViewAccount: View {
    
    let account: Account
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
        
            .foregroundStyle(.brightGold)
            .overlay {
                ZStack {
                    if account.isCreditCard {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("BankAccount/stroke"), lineWidth: 2)
                    }
                    VStack {
                        Text(account.name)
                            .font(.caption)
                            .foregroundStyle(.black)
                        Spacer()
                        if account.isCreditCard {
                            Text("R$ \(String(format: "%.2f", account.total))")
                                .font(.caption2)
                                .foregroundStyle(.red)
                        } else {
                            Text("R$ \(String(format: "%.2f", account.total))")
                                .font(.caption2)
                                .foregroundStyle(.green)
                        }
                        
                    }
                    .padding(10)
                }
            }
            .frame(width: 110, height: 130)
    }
}

#Preview {
    BankAccountViewAccount(account: .init(idBankAccount: UUID(), name: "Safade", isCreditCard: true))
}
