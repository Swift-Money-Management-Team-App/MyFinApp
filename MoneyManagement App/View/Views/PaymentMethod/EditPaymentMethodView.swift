import SwiftUI
import UIKit

struct EditPaymentMethodView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name: String
    @State private var emoji: String
    @State private var showCancelAlert = false
    @State private var currentPage = 0

    var method: Method?
    var onSave: (Method) -> Void

    init(method: Method? = nil, onSave: @escaping (Method) -> Void) {
        self.method = method
        self._name = State(initialValue: method?.name ?? "")
        self._emoji = State(initialValue: method?.emoji ?? "")
        self.onSave = onSave
        UIPageControl.appearance().currentPageIndicatorTintColor = .orange
        UIPageControl.appearance().pageIndicatorTintColor = .gray
    }

    private let emojis = [
        "pencil", "gamecontroller", "car", "bicycle", "wallet.pass", "bed.double", "cart", "creditcard",
        "drop", "bus", "popcorn", "bolt", "fork.knife", "book", "bag", "airplane",
        "dollarsign.circle", "chart.bar", "banknote", "bitcoinsign.circle", "creditcard.and.123", "cart.fill",
        "bag.fill", "chart.pie", "gift", "globe", "star", "sparkles", "building.columns", "scroll", "briefcase", "map.fill"
    ]
    
    private var emojiPages: [[String]] {
        stride(from: 0, to: emojis.count, by: 8).map { Array(emojis[$0..<min($0 + 8, emojis.count)]) }
    }

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

                VStack(alignment: .leading, spacing: 16) {
                    TextField("Nome", text: $name)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Text("Selecione um emoji")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    TabView(selection: $currentPage) {
                        ForEach(emojiPages.indices, id: \.self) { index in
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 20) {
                                ForEach(emojiPages[index], id: \.self) { emojiItem in
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
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 150)
                }
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 4)
                .padding(.horizontal)

                
                HStack(spacing: 4) {
                    ForEach(emojiPages.indices, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.orange : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 12)

                Spacer()
            }
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
        }
    }
}

#Preview {
    EditPaymentMethodView { _ in }
}
