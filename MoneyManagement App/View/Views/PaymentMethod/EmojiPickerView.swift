import SwiftUI

struct EmojiPickerView: View {
    @Binding var selectedEmoji: String
    @Environment(\.dismiss) var dismiss
    
    let emojis = [
        "pencil", "gamecontroller", "car", "bicycle", "wallet.pass", "bed.double", "cart", "creditcard",
        "drop", "bus", "popcorn", "bolt", "fork.knife", "book", "bag", "airplane"
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("Escolha um Emoji")
                .font(.headline)
                .padding()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(emojis, id: \.self) { emoji in
                        Image(systemName: emoji)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .padding()
                            .background(selectedEmoji == emoji ? Color.orange : Color.clear) // Destaque para o selecionado
                            .clipShape(Circle())
                            .onTapGesture {
                                selectedEmoji = emoji
                                dismiss()
                            }
                    }
                }
                .padding()
            }
            
            Button("Fechar") {
                dismiss()
            }
            .padding()
        }
    }
}

#Preview {
    EmojiPickerView(selectedEmoji: .constant("pencil"))
}
