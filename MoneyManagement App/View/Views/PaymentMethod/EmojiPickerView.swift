import SwiftUI

struct EmojiPickerView: View {
    @Binding var selectedEmoji: String
    @Environment(\.dismiss) var dismiss
    
    let emojis = [
        "💵", "💰", "💳", "🏦", "💸", "📈", "📉", "💹", "🪙", "💷", "💶", "💴", "💎", "🧾", "💱", "💲", "🔖", "🛒", "📊", "📋", "💼", "🏷️", "📥", "📤", "🔐",
        "🗂", "🗃️", "📂", "📑", "🧮", "🗄️", "🗞️", "📰", "💻", "🖥️", "💼", "🏢"
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
                        Text(emoji)
                            .font(.largeTitle)
                            .padding()
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
    EmojiPickerView(selectedEmoji: .constant("💵"))
}
