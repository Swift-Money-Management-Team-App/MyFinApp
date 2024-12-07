import SwiftUI

struct ValueRow: View {
    
    var value: Double
    
    var body: some View {
        Text("R$ \(String(format: "%.2f", value))")
            .foregroundStyle(.black)
            .frame(height: 20)
    }
}

#Preview {
    ValueRow(value: 500)
}
