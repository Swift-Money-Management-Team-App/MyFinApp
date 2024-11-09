import SwiftUI

struct DetailPaymentMethodView: View {
    var method: Method
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var isPresentingEditView = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                HStack {
                    Button("Voltar") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Visualizar método de\npagamento")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button("Editar") {
                        isPresentingEditView = true
                    }
                }
                .padding()
                
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text(method.name)
                        .font(.title2)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    
                    VStack {
                        Image(systemName: method.emoji)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .padding()
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 4)
                .padding(.horizontal)
                
                
                Button(action: {
                    showDeleteAlert = true
                }) {
                    Text("Apagar Método de Pagamento")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .alert("Excluir Método de Pagamento?", isPresented: $showDeleteAlert) {
                    Button("Excluir", role: .destructive) {
                        deleteMethod()
                    }
                    Button("Cancelar", role: .cancel) {}
                }
                
                Spacer()
            }
            .sheet(isPresented: $isPresentingEditView) {
                EditPaymentMethodView(method: method) { updatedMethod in
                    
                }
            }
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
        }
    }
    
    private func deleteMethod() {
        modelContext.delete(method)
        dismiss()
    }
}

#Preview {
    DetailPaymentMethodView(method: Method(idUser: UUID(), emoji: "cart", name: "Cartão de Débito"))
}
