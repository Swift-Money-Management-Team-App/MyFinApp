import SwiftUI

// Modelo simplificado para método de pagamento
struct PaymentMethod: Identifiable {
    let id = UUID()
    var name: String
    var emoji: String
}

struct PaymentMethodView: View {
    @State private var paymentMethods: [PaymentMethod] = []
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
                        Text(method.emoji)
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
                paymentMethods.append(newMethod)
                isPresentingEditView = false
            }
        }
    }
    
    private func deleteItem(at offsets: IndexSet) {
        paymentMethods.remove(atOffsets: offsets)
    }
}

#Preview {
    NavigationStack { 
        PaymentMethodView()
    }
}
