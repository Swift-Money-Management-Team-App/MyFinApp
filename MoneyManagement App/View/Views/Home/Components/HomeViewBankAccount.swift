import SwiftUI

struct HomeViewBankAccount: View {
    let bankAccount: BankAccount
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.brightGold)
            .overlay {
                VStack {
                    Text(bankAccount.name)
                        .font(.caption)
                        .foregroundStyle(.black)
                    Spacer()
                    Text("R$ \(String(format: "%.2f", bankAccount.total))")
                        .font(.caption2)
                        .foregroundStyle(.black)
                }
                .padding(10)
            }
            .frame(width: 110, height: 130)
    }
}

#Preview {
    HomeViewBankAccount(bankAccount: BankAccount.init(idUser: .init(), name: "Banco do Brasil"))
}
