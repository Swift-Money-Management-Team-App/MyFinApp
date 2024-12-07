import SwiftUI
import SwiftData

struct AddMovementViewEarningCategory: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Query var earningCategories: [EarningCategory]
    // Entrada de Dados
    @Binding var selectedEarningCategory: EarningCategory?
    // Dados para visualização
    
    // Booleans para visualização
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(earningCategories) { earningCategory in
                        Button(action: { self.selectedEarningCategory = earningCategory }) {
                            HStack {
                                Text(earningCategory.name)
                                    .foregroundStyle(.black)
                                Spacer()
                                if self.selectedEarningCategory == earningCategory {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(LocalizedStringKey.back.button) { dismiss() }
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(LocalizedStringKey.earningCategory.label)
                    }
                }
            }
        }
    }
    
}

#Preview {
    AddMovementViewEarningCategory(selectedEarningCategory: .constant(.init(idUser: UUID(), emoji: "Safade", name: "Safade")))
}

