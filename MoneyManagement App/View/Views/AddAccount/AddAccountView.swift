import SwiftUI
import SwiftData

struct AddAccountView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var accountName: String
    @Binding var isCreditCard: Bool
    @Binding var invoiceClosing: Int
    @State var showAlertDiscard: Bool = false
    var bankAccount: BankAccount
    let modelContext: ModelContext
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text(LocalizedStringKey.addAccountNameField.label)
                    .padding(.trailing)
                TextField(LocalizedStringKey.addAccountPlaceholder.label, text: $accountName)
                
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
                Toggle(LocalizedStringKey.addAccountToggle.label, isOn: $isCreditCard)
                if isCreditCard {
                    Divider()
                    HStack {
                        Text(LocalizedStringKey.addAccountInvoiceField.label)
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
        .navigationTitle(LocalizedStringKey.addAccountScreenTitle.label)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(LocalizedStringKey.addAccountBackButton.button) { 
                    showAlertDiscard = !(accountName.isEmpty)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(LocalizedStringKey.addAccountSaveButton.button) {
                    action()
                }
            }
        }
        .alert(LocalizedStringKey.addAccountDiscardAlertTitle.message, isPresented: $showAlertDiscard) {
            Button(LocalizedStringKey.addAccountDiscardButton.button, role: .destructive) {
                dismiss()
            }
            Button(LocalizedStringKey.addAccountContinueEditingButton.button, role: .cancel) {}
                .fontWeight(.bold)
        }
    }
}
