import SwiftUI

struct HomeViewConditionCell: View {
    let type: ConditionCellType
    @Binding var valueAllAccounts: Double
    @Binding var hiddenValues: Bool
    var body: some View {
        Button {
            // TODO: Colocar para aparecer a tela de Usuário
        } label: {
            HStack {
                Label {
                    HStack {
                        VStack (alignment: .leading, spacing: 2) {
                            (type == .credit ? Text("Cartão de Crédito") : Text("Conta Corrente"))
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
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .bold))
                    }
                } icon: {}
                    .labelStyle(.titleOnly)
            }
            .frame(height: 45)
            .padding(5)
            .padding(.horizontal, 10)
        }
    }
}

enum ConditionCellType {
    case credit
    case current
}

#Preview {
    HomeViewConditionCell(type: .credit, valueAllAccounts: Binding.constant(2000.00), hiddenValues: Binding.constant(true))
}
