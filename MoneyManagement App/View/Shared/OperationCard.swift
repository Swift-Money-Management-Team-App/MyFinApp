import SwiftUI

struct OperationCard: View {
    
    let type: OperationCardType
    let icon: String
    let text: String
    
    init(type: OperationCardType, text: String) {
        self.type = type
        switch(type) {
        case .addMovement:
            self.icon = "note.text.badge.plus"
        case .movementCategory:
            self.icon = "square.stack.3d.down.right"
        case .paymentMethod:
            self.icon = "banknote"
        case .generalHistory:
            self.icon = "chart.xyaxis.line"
        }
        self.text = text
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
                        .multilineTextAlignment(.center)
                }
            }
    }
}

enum OperationCardType {
    case addMovement
    case movementCategory
    case paymentMethod
    case generalHistory
}

#Preview {
    OperationCard(type: .addMovement, text: "Adicionar movimentação")
}
