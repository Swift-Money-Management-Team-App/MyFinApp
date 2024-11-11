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
                    
                    Text("Nome")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    Text(method.name)
                        .font(.title3)
                        .padding(.horizontal)
                        .foregroundColor(.primary)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    VStack {
                        Image(systemName: method.emoji)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .padding()
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.vertical, 8)
                .background(Color.white)
                
                Divider()
                
                Button(action: {
                    showDeleteAlert = true
                }) {
                    Text("Apagar Método de Pagamento")
                        .foregroundColor(.red)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                }
                .background(Color.white)
                .alert("Excluir Método de Pagamento \"\(method.name)\"?", isPresented: $showDeleteAlert) {
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
    DetailPaymentMethodView(method: Method(idUser: UUID(), emoji: "fork.knife", name: "Cartão de Débito"))
}
