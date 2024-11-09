import SwiftUI

struct EditPaymentMethodView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name: String
    @State private var emoji: String
    @State private var showEmojiPicker = false
    @State private var showCancelAlert = false

    var method: Method?
    
    var onSave: (Method) -> Void

    init(method: Method? = nil, onSave: @escaping (Method) -> Void) {
        self.method = method
        self._name = State(initialValue: method?.name ?? "")
        self._emoji = State(initialValue: method?.emoji ?? "")
        self.onSave = onSave
    }

    private let emojis = [
        "pencil", "gamecontroller", "car", "bicycle", "wallet.pass", "bed.double", "cart", "creditcard",
        "drop", "bus", "popcorn", "bolt", "fork.knife", "book", "bag", "airplane"
    ]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Button("Cancelar") {
                        showCancelAlert = true 
                    }
                    .alert("Cancelar \(method == nil ? "adição do novo método de pagamento" : "edição do novo método de pagamento")?", isPresented: $showCancelAlert) {
                        Button("Sim", role: .destructive) {
                            dismiss()
                        }
                        Button("Não", role: .cancel) {}
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
                        
                        VStack(alignment: .leading) {
                            Text("Selecione um emoji")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(emojis, id: \.self) { emojiItem in
                                    Image(systemName: emojiItem)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .padding(8)
                                        .background(self.emoji == emojiItem ? Color.orange.opacity(0.3) : Color.clear)
                                        .clipShape(Circle())
                                        .onTapGesture {
                                            self.emoji = emojiItem
                                        }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EditPaymentMethodView { _ in }
}
