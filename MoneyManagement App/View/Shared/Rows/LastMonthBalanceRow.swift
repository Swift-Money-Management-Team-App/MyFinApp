import SwiftUI

struct LastMonthBalanceRow: View {
    
    var value: Double
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey.lastMonthBalance.label)
                .foregroundStyle(.black)
                .font(.body)

            Spacer()
            Text("\(LocalizedStringKey.currencySymbol.label)\(String(format: "%.2f", self.value))")
                .foregroundStyle(.black)
                .font(.body)
        }
    }
}

#Preview {
    LastMonthBalanceRow(value: 50.30)
}
