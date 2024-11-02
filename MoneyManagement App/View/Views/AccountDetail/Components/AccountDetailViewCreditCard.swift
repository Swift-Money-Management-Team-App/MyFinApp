import SwiftUI

struct AccountDetailViewCreditCard: View {
    var name : String
    var value : Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(.accent, lineWidth: 2)
            .fill(.brightGold)
            .foregroundStyle(.brightGold)
            .overlay {
                VStack {
                    Text(name)
                        .font(.caption)
                        .fontWeight(.bold)
                    Spacer()
                    Text("R$ \(String(format: "%.2f", value))")
                        .font(.caption2)
                        .foregroundStyle(.red)
                        .fontWeight(.bold)
                }
                .padding(10)
            }
            .frame(width: 100, height: 100)
    }
}

#Preview {
    AccountDetailViewCreditCard(name: "Caixinha", value: 100000)
}
