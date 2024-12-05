import SwiftUI
import SwiftData

struct AddMovementViewExpenseCategory: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Query var expenseCategories: [ExpenseCategory]
    // Entrada de Dados
    @Binding var selectedExpenseCategory: ExpenseCategory?
    // Dados para visualização
    
    // Booleans para visualização
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(expenseCategories) { expenseCategory in
                        Button(action: { self.selectedExpenseCategory = expenseCategory }) {
                            HStack {
                                Text(expenseCategory.name)
                                    .foregroundStyle(.black)
                                Spacer()
                                if self.selectedExpenseCategory == expenseCategory {
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
                        Text(LocalizedStringKey.expenseCategory.label)
                    }
                }
            }
        }
    }
    
}

#Preview {
    AddMovementViewExpenseCategory(
        selectedExpenseCategory: .constant(.init(idUser: UUID(), emoji: "📦", name: "Exemplo"))
    )
}

