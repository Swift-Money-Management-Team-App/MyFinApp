import SwiftUI

struct LastMonthBalanceRow: View {
    
    var value: Double
    
    var body: some View {
        HStack {
            Text("Saldo do Mês Anterior")
                .foregroundStyle(.black)
                .font(.body)

            Spacer()
            Text("R$ \(String(format: "%.2f", self.value))")
                .foregroundStyle(.black)
                .font(.body)
        }
    }
}

#Preview {
    LastMonthBalanceRow(value: 50.30)
}
