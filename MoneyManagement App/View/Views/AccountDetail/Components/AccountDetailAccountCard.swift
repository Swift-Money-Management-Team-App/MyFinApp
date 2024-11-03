import Foundation
import SwiftUI

struct AccountDetailAccountCard : View{
    var name : String
    var value : Double
    
    var body: some View {
        VStack {
            RoundedRectangle (cornerRadius: 20)
                .fill(.brightGold)
                .frame(width: 100, height: 120)
                .overlay {
                    VStack {
                        Text(name)
                            .fontWeight(.bold)
                            .font(.caption)
                        Spacer()
                        Text("R$ \(String(format: "%.2f", value))")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical)
                }
        }
    }
}

#Preview {
    AccountDetailAccountCard(name: "Conta Corrente", value: 500)
}
