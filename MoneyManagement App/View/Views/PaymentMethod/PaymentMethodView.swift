import SwiftUI
import SwiftData

struct PaymentMethodView: View {
    @Query private var paymentMethods: [Method]
    @Environment(\.modelContext) private var modelContext
    
    @State private var isPresentingEditView = false
    @State private var methodToEdit: Method?
    
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
                        methodToEdit = method
                        isPresentingEditView = true
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .listStyle(PlainListStyle())
        }
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
    
    private func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let method = paymentMethods[index]
            modelContext.delete(method)
        }
    }
}

#Preview {
    NavigationStack {
        PaymentMethodView()
    }
}
