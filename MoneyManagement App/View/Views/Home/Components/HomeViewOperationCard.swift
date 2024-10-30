import SwiftUI

struct HomeViewOperationCard: View {
    let type: OperationCard
    let icon: String
    let text: String
    
    init(type: OperationCard) {
        self.type = type
        switch(type) {
        case .addMovement:
            self.icon = "note.text.badge.plus"
            self.text = "Adicionar movimentação"
        case .movementCategory:
            self.icon = "square.stack.3d.down.right"
            self.text = "Categoria de transação"
        case .paymentMethod:
            self.icon = "banknote"
            self.text = "Método de pagamento"
        case .generalHistory:
            self.icon = "chart.xyaxis.line"
            self.text = "Histórico Geral"
        }
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.darkGold, lineWidth: 5)
            .fill(.white)
            .frame(width: 105, height: 100)
            .overlay {
                VStack {
                    Image (systemName: icon)
                        .foregroundStyle(.darkGold)
                        .padding(.vertical)
                    Text(text)
                        .foregroundStyle(.darkGold)
                        .font(.caption)
                }
            }
    }
}

enum OperationCard {
    case addMovement
    case movementCategory
    case paymentMethod
    case generalHistory
}

#Preview {
    HomeViewOperationCard(type: .addMovement)
}
