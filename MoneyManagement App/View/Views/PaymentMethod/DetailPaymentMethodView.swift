import SwiftUI

struct DetailPaymentMethodView: View {
    var method: Method
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var isEditing = false
    @State private var showDeleteAlert = false
    
    @State private var name: String
    @State private var emoji: String
    
    init(method: Method) {
        self.method = method
        _name = State(initialValue: method.name)
        _emoji = State(initialValue: method.emoji)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                HStack {
                    Button("Voltar") {
                        if isEditing {
                            isEditing = false
                        } else {
                            dismiss()
                        }
                    }
                    
                    Spacer()
                    
                    Text(isEditing ? "Editar método de\npagamento" : "Visualizar método de\npagamento")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button(isEditing ? "Salvar" : "Editar") {
                        if isEditing {
                            saveChanges()
                        } else {
                            isEditing = true
                        }
                    }
                    .disabled(name.isEmpty || emoji.isEmpty)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Nome")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    if isEditing {
                        TextField("Nome", text: $name)
                            .padding(.horizontal)
                    } else {
                        Text(name)
                            .font(.title3)
                            .padding(.horizontal)
                            .foregroundColor(.primary)
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Text("Emoji")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    if isEditing {
                        EmojiPicker(selectedEmoji: $emoji)
                    } else {
                        VStack {
                            Image(systemName: emoji)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .padding()
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .padding(.vertical, 8)
                .background(Color.white)
                
                Divider()
                
                if !isEditing {
                    Button(action: {
                        showDeleteAlert = true
                    }) {
                        Text("Apagar Método de Pagamento")
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                    }
                    .background(Color.white)
                    .alert("Excluir Método de Pagamento \"\(method.name)\"?", isPresented: $showDeleteAlert) {
                        Button("Excluir", role: .destructive) {
                            deleteMethod()
                        }
                        Button("Cancelar", role: .cancel) {}
                    }
                }
                
                Spacer()
            }
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
        }
    }
    
    private func saveChanges() {
        method.name = name
        method.emoji = emoji
        isEditing = false
    }
    
    private func deleteMethod() {
        modelContext.delete(method)
        dismiss()
    }
}

struct EmojiPicker: View {
    @Binding var selectedEmoji: String
    private let emojis = [
        "pencil", "gamecontroller", "car", "bicycle", "wallet.pass", "bed.double", "cart", "creditcard",
        "drop", "bus", "popcorn", "bolt", "fork.knife", "book", "bag", "airplane",
        "dollarsign.circle", "chart.bar", "banknote", "bitcoinsign.circle", "creditcard.and.123", "cart.fill",
        "bag.fill", "chart.pie", "gift", "globe", "star", "sparkles", "building.columns", "scroll", "briefcase", "map.fill"
    ]
    
    private var emojiPages: [[String]] {
        stride(from: 0, to: emojis.count, by: 8).map { Array(emojis[$0..<min($0 + 8, emojis.count)]) }
    }
    
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(emojiPages.indices, id: \.self) { index in
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 20) {
                        ForEach(emojiPages[index], id: \.self) { emojiItem in
                            Image(systemName: emojiItem)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .padding(8)
                                .background(selectedEmoji == emojiItem ? Color.orange.opacity(0.3) : Color.clear)
                                .clipShape(Circle())
                                .onTapGesture {
                                    selectedEmoji = emojiItem
                                }
                        }
                    }
                    .padding()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 150)
            
            
            HStack(spacing: 4) {
                ForEach(emojiPages.indices, id: \.self) { index in
                    Circle()
                        .fill(index == currentPage ? Color.orange : Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 8)
        }
    }
}

#Preview {
    DetailPaymentMethodView(method: Method(idUser: UUID(), emoji: "fork.knife", name: "Cartão de Débito"))
}
