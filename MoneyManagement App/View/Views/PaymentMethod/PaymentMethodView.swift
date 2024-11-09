import SwiftUI
import SwiftData

struct PaymentMethodView: View {
    @Query private var paymentMethods: [Method]
    @Environment(\.modelContext) private var modelContext
    
    @State private var isPresentingEditView = false
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
                    isPresentingEditView = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            EditPaymentMethodView { newMethod in
                
                modelContext.insert(newMethod)
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
