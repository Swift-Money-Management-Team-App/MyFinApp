import SwiftUI

struct EditPaymentMethodView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name: String
    @State private var emoji: String
    @State private var showEmojiPicker = false

    var method: Method?
    
    var onSave: (Method) -> Void

    init(method: Method? = nil, onSave: @escaping (Method) -> Void) {
        self.method = method
        self._name = State(initialValue: method?.name ?? "")
        self._emoji = State(initialValue: method?.emoji ?? "")
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Button("Cancelar") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text(method == nil ? "Novo método de\npagamento" : "Editar método de\npagamento")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button(method == nil ? "Adicionar" : "Salvar") {
                        if let existingMethod = method {
                            
                            existingMethod.name = name
                            existingMethod.emoji = emoji
                            onSave(existingMethod)
                        } else {
                            // Create a new method
                            let newMethod = Method(idUser: UUID(), emoji: emoji, name: name)
                            onSave(newMethod)
                        }
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
