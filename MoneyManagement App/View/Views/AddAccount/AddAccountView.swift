import SwiftUI
import SwiftData

struct AddAccountView: View {
//    var account : Account?
    //@ObservedObject var vm : AddAccountViewModel
    @Environment(\.dismiss) var dismiss
    
    @Binding var accountName : String
    @Binding var isCreditCard : Bool
    @Binding var invoiceClosing : Int
    @State var showAlertDiscard : Bool = false
    //var account : Account?
    var bankAccount : BankAccount
    let modelContext : ModelContext
    
    let action : () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Nome")
                    .padding(.trailing)
                TextField("Conta poupança", text: $accountName)
                
                if !accountName.isEmpty {
                    Button {
                        accountName = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .foregroundStyle(.secondary)
                }
            }
            .padding()
            .background(Color.backgroundColorRow)
            .padding(.bottom)
            
            VStack {
                Toggle("Criar como cartão de crédito", isOn: $isCreditCard)
                if isCreditCard {
                    Divider()
                    //DatePicker("", selection: $vm.invoiceClosing, in: Date() ... Date.distantFuture, displayedComponents: .date)
                      //  .datePickerStyle(.compact)
                    
                    HStack {
                        Text("Dia do fechamento da fatura")
                        Spacer()
                        TextField("0", value: $invoiceClosing, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .frame(width: 30, alignment: .trailing)
                    }
                }
            }
            .padding()
            .background(Color.backgroundColorRow)
            
            Spacer()
        }
        .background(Color.background)
        .navigationTitle("Adicionar conta")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Button ("Voltar") {
                    showAlertDiscard = !(accountName.isEmpty)
                }
                
            }
            
            
            ToolbarItem(placement: .topBarTrailing) {
                Button ("Salvar") {
                    action()
                }
            }
        }
        .alert("Tem certeza de que deseja descartar estas alterações", isPresented: $showAlertDiscard) {
            
            Button("Descartar Alterações", role: .destructive) {
                dismiss()
            }
            
            Button("Continuar Editando", role: .cancel) {}
            .fontWeight(.bold)
        }
    }
}

/*
 #Preview {
 NavigationStack {
 //AddAccountView(account: nil)
 }
 }
 */
