import SwiftUI
import SwiftData

struct CategoryFormCreateView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var user: [User]
    // Entrada de Dados
    @State var name: String = ""
    @State var emoji: String = "plus.square"
    // Dados para visualização
    @Binding var type: CategoriesType
    @State var edited: Bool = false
    // Booleans para visualização
    @State var categoryTypeBool: Bool = false
    @State var showCancelEditAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Toggle(isOn: $categoryTypeBool) {
                        Text(self.categoryTypeBool ? LocalizedStringKey.earning.label : LocalizedStringKey.expense.label)
                    }
                    .onChange(of: self.categoryTypeBool) {
                        self.type = self.categoryTypeBool ? .earning : .expense
                    }
                    HStack {
                        Text(LocalizedStringKey.name.label)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextField(LocalizedStringKey.namePlaceholder.label, text: $name)
                            .onChange(of: self.name) {
                                self.edited = true
                            }
                    }
                    EmojiPicker(selectedEmoji: $emoji)
                        .onChange(of: self.emoji) {
                            self.edited = true
                        }
                }
                .listStyle(.grouped)
            }
            .padding(.vertical)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
            .navigationTitle(LocalizedStringKey.newCategory.label)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(LocalizedStringKey.back.button) {
                        if self.edited {
                            self.showCancelEditAlert.toggle()
                        } else {
                            dismiss()
                        }
                    }
                }
                ToolbarItem {
                    Button(LocalizedStringKey.add.button) {
                        self.appendCategory()
                        dismiss()
                    }
                    .disabled(name.isEmpty || emoji.isEmpty)
                }
            }
        }
        .onAppear {
            self.categoryTypeBool = self.type == .earning
        }
        .alert(LocalizedStringKey.discardNewCategory.message, isPresented: $showCancelEditAlert) {
            Button(LocalizedStringKey.discardChanges.button, role: .destructive) {
                dismiss()
            }
            Button(LocalizedStringKey.continueEditing.button, role: .cancel) {}
        }
    }
}

#Preview {
    CategoryFormCreateView(type: .constant(.expense))
}
