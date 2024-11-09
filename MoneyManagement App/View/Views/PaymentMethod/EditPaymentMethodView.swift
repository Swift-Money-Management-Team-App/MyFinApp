import SwiftUI

struct EditPaymentMethodView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var emoji: String = ""
    @State private var showEmojiPicker = false 
    
    var onSave: (PaymentMethod) -> Void
    
    let financialEmojis = [
        "💵", "💰", "💳", "🏦", "💸", "📈", "📉", "💹", "🪙", "💷", "💶", "💴", "💎", "🧾", "💱", "💲", "🔖", "🛒", "📊", "📋", "💼", "🏷️", "📥", "📤", "🔐"
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Button("Cancelar") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Novo método de\npagamento")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button("Adicionar") {
                        let newMethod = PaymentMethod(name: name, emoji: emoji)
                        onSave(newMethod)
                        dismiss()
                    }
                    .disabled(name.isEmpty || emoji.isEmpty)
                }
                .padding()
                
                Form {
                    Section(header: Text("Detalhes do Método de Pagamento")) {
                        TextField("Tipo de Pagamento", text: $name)
                        
                        
                        HStack {
                            Text("Emoji")
                            Spacer()
                            Text(emoji.isEmpty ? "Selecione um emoji" : emoji)
                                .foregroundColor(emoji.isEmpty ? .gray : .primary)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            showEmojiPicker = true
                        }
                    }
                }
            }
            
            .sheet(isPresented: $showEmojiPicker) {
                EmojiPickerView(selectedEmoji: $emoji)
            }
        }
    }
}

#Preview {
    EditPaymentMethodView { _ in }
}
