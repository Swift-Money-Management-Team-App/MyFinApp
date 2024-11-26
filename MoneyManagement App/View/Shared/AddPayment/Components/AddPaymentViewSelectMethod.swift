import SwiftUI
import SwiftData

struct AddPaymentViewSelectMethod: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Query var methods: [Method]
    // Entrada de Dados
    @Binding var selectedMethod: Method?
    // Dados para visualização
    
    // Booleans para visualização
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(methods) { method in
                    Button(action: { self.selectedMethod = method }) {
                        HStack{
                            Text(method.name)
                                .foregroundStyle(.black)
                            Spacer()
                            if self.selectedMethod == method {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.blue)
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
                    Button("Voltar") { dismiss() }
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Método de Pagamento")
                        
                    }
                }
            }
        }
    }
    
}

#Preview {
    AddPaymentViewSelectMethod(selectedMethod: .constant(.init(idUser: UUID(), emoji: "Safade", name: "Safade")))
}

