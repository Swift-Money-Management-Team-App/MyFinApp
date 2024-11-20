import SwiftUI
import SwiftData

struct AddPaymentViewSelectMethod: View {
    
    @Binding var selectedMethod: Method
    @Query var methods: [Method]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(methods) { method in
                    Button(action: { }) {
                        HStack{
                            Text(method.name)
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundStyle(.blue)
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {}) {
                        Text("Voltar")
                    }
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Método de Pagamento")
                        
                    }
                }
            }
            .background(Color.background)
        }
    }
    
}

#Preview {
    AddPaymentViewSelectMethod(selectedMethod: .constant(.init(idUser: UUID(), emoji: "Safade", name: "Safade")))
}

