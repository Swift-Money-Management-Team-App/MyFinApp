import SwiftUI

struct ConditionCell: View {
    
    let cellName: String
    @Binding var valueAllAccounts: Double
    @Binding var hiddenValues: Bool
    
    var body: some View {
        Label {
            VStack (alignment: .leading, spacing: 2) {
                Text(self.cellName)
                    .foregroundStyle(.black)
                if (hiddenValues) {
                    HStack(spacing: 4) {
                        ForEach(1..<6) { _ in
                            Image(systemName: "circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 12)
                                .foregroundStyle(.black)
                        }
                    }
                    .frame(height: 20)
                    .padding(0)
                } else {
                    Text("R$ \(String(format: "%.2f", valueAllAccounts))")
                        .foregroundStyle(.black)
                        .frame(height: 20)
                }
            }
        } icon: {}
            .labelStyle(.titleOnly)
    }
    
}
#Preview {
    //    ConditionCell(cellName: "Safade", valueAllAccounts: Binding.constant(2000.00), hiddenValues: Binding.constant(false))
    List {
        ConditionCell(cellName: "Safade", valueAllAccounts: Binding.constant(2000.00), hiddenValues: Binding.constant(false))
        ConditionCell(cellName: "Safade", valueAllAccounts: Binding.constant(2000.00), hiddenValues: Binding.constant(false))
    }
    .listStyle(.inset)
}
