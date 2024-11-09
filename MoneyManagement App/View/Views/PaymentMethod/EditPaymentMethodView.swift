import SwiftUI

struct EditPaymentMethodView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name: String = ""
    @State private var emoji: String = ""
    @State private var showEmojiPicker = false
    
    var onSave: (Method) -> Void
    
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
                        let newMethod = Method(idUser: UUID(), emoji: emoji, name: name)
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
                            if !emoji.isEmpty {
                                Image(systemName: emoji) 
                                    .foregroundColor(.primary)
                            } else {
                                Text("Selecione um emoji")
                                    .foregroundColor(.gray)
                            }
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
