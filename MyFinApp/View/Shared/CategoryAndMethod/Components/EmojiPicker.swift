import SwiftUI

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
    EmojiPicker(selectedEmoji: .constant("arrow.right"))
}
