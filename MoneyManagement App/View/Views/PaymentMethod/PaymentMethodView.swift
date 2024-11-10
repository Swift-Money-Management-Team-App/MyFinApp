import SwiftUI
import SwiftData

struct PaymentMethodView: View {
    @Query private var paymentMethods: [Method]
    @Environment(\.modelContext) private var modelContext
    
    @State private var isPresentingEditView = false
    @State private var methodToEdit: Method?
    @State private var methodToDelete: Method?
    @State private var showDeleteAlert = false
    @State private var selectedMethod: Method?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.brightGold)
                .frame(maxHeight: 175)
                .ignoresSafeArea(edges: .top)
            
            List {
                ForEach(paymentMethods) { method in
                    HStack {
                        Image(systemName: method.emoji)
                            .foregroundColor(.primary)
                        Text(method.name)
                    }
                    .onTapGesture {
                        selectedMethod = method
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            methodToDelete = method
                            showDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .alert("Excluir Método de Pagamento?", isPresented: $showDeleteAlert, presenting: methodToDelete) { method in
                Button("Excluir", role: .destructive) {
                    delete(method)
                }
                Button("Cancelar", role: .cancel) {}
            } message: { method in
                Text("Tem certeza de que deseja excluir o método de pagamento \"\(method.name)\"?")
            }
            .sheet(item: $selectedMethod) { method in
                DetailPaymentMethodView(method: method)
            }
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationTitle("Métodos de Pagamento")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(Color.yellow, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Início")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    methodToEdit = nil
                    isPresentingEditView = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            EditPaymentMethodView(method: methodToEdit) { newOrUpdatedMethod in
                if let existingMethod = methodToEdit {
                    existingMethod.emoji = newOrUpdatedMethod.emoji
                    existingMethod.name = newOrUpdatedMethod.name
                } else {
                    modelContext.insert(newOrUpdatedMethod)
                }
                isPresentingEditView = false
            }
        }
    }
    
    private func delete(_ method: Method) {
        modelContext.delete(method)
    }
}

#Preview {
    NavigationStack {
        PaymentMethodView()
    }
}
