import SwiftUI
import SwiftData

struct AddPaymentView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var accounts: [Account]
    @Query var bankAccounts: [BankAccount]
    @Query var methods: [Method]
    // Entrada de Dados
    @State var account: Account? = nil
    @State var bankAccount: BankAccount? = nil
    @State var method: Method? = nil
    @State var value: Double = 0.00
    @State var time: Date = .now
    @State var competence : Date = .now
    @Binding var payment: Payment?
    @Binding var movement: Movement?
    @Binding var payments: [Payment]
    let actionUpdate: () -> Void
    // Dados para visualização
    let type: AddPaymentType
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyCode = "BRL"
        formatter.currencySymbol = "R$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 2
        formatter.maximumIntegerDigits = 13
        formatter.usesGroupingSeparator = true
        return formatter
    }()
    // Booleans para visualização
    @State var alertCancel: Bool = false
    @State var selectAccount: Bool = false
    @State var selectBankAccount: Bool = false
    @State var selectMethod: Bool = false
    @State var showCustomDatePicker: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Label {} icon: {
                        HStack {
                            Image(systemName: "wallet.bifold")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(20)
                    }
                    .labelStyle(.iconOnly)
                    Button(action: { self.selectBankAccount.toggle() }) {
                        HStack {
                            Text("Institução Financeira")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)
                            HStack {
                                Text(self.bankAccount?.name ?? "Bradesco")
                                    .foregroundStyle(.gray)
                                Image(systemName: "chevron.forward")
                                    .foregroundStyle(.gray)
                            }
                            
                        }
                    }
                    .onChange(of: self.bankAccount) { _, _ in
                        self.account = accounts.filter({ account in account.idBankAccount == self.bankAccount?.id }).first!
                    }
                    Button(action: { self.selectAccount.toggle() }) {
                        HStack {
                            Text("Conta")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)
                            HStack {
                                Text(self.account?.name ?? ".Hak")
                                    .foregroundStyle(.gray)
                                Image(systemName: "chevron.forward")
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
                Section {
                    Button(action: { self.selectMethod.toggle() }) {
                        HStack {
                            Text("Método de pagamento")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)
                            HStack {
                                Text(self.method?.name ?? "Hackeando")
                                    .foregroundStyle(.gray)
                                Image(systemName: "chevron.forward")
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    Label(title: {
                        HStack {
                            Text("Valor")
                            Spacer()
                            HStack {
                                Text("R$")
                                CurrencyTextField(numberFormatter: currencyFormatter, value: $value)
                            }
                            .fixedSize()
                        }
                        
                    }, icon: {})
                    .labelStyle(.titleOnly)
                    Label(title: {
                        DatePicker("Horário", selection: $time, displayedComponents: [.hourAndMinute])
                    }, icon: {})
                    .labelStyle(.titleOnly)
                    if self.account?.isCreditCard ?? false {
                        Button(action: { self.showCustomDatePicker.toggle() }) {
                            HStack {
                                Text("Competência")
                                    .foregroundStyle(.black)
                                Spacer()
                                Text(self.competence, format: .dateTime.month(.twoDigits).year())
                                    .foregroundStyle(.black)
                                    .padding(6)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundStyle(.gray)
                                            .opacity(0.2)
                                    }
                            }
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }) {
                        Text("Cancelar")
                    }
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(self.type == .create ? "Adicionar pagamento": "Editar pagamento")
                        
                    }
                }
                ToolbarItem {
                    Button(action: {
                        if self.type == .create {
                            self.addPayment()
                        } else {
                            self.changePayment()
                            self.actionUpdate()
                        }
                        dismiss()
                    }) {
                        Text(self.type == .create ? "Adicionar": "Editar")
                    }
                }
            }
        }
        .onAppear {
            if let payment = self.payment {
                self.bankAccount = self.bankAccounts.filter({ $0.id == self.accounts.filter({ $0.id == payment.idAccount }).first!.idBankAccount }).first!
                self.account =  self.accounts.filter({ $0.id == payment.idAccount }).first!
                self.method = self.methods.filter({ $0.id == payment.idMethod }).first
                self.value = payment.value
                self.time = payment.time
                self.competence = payment.competence ?? Date.now
            } else {
                if let account = self.account {
                    self.account = account
                } else {
                    self.account = accounts.first!
                }
                if let bankAccount = self.bankAccount {
                    self.bankAccount = bankAccount
                } else {
                    self.bankAccount = bankAccounts.first!
                }
                self.method = methods.first!
            }
        }
        .alert("Tem certeza de que deseja descartar estas alterações?", isPresented: $alertCancel) {
            Button("Continuar Editando", role: .cancel) {}
                .tint(.blue)
            Button("Descartar Alterações", role: .destructive) {}
        }
        .fullScreenCover(isPresented: $selectAccount, content: {
            AddPaymentViewSelectAccount(selectedAccount: self.$account, bankAccount: $bankAccount)
        })
        .fullScreenCover(isPresented: $selectBankAccount, content: {
            AddPaymentViewSelectBankAccount(selectedBankAccount: self.$bankAccount)
        })
        .fullScreenCover(isPresented: $selectMethod, content: {
            AddPaymentViewSelectMethod(selectedMethod: self.$method)
        })
        .sheet(isPresented: $showCustomDatePicker) {
            YearMonthPickerView(selectedDate: $competence)
        }
    }
    
}

#Preview {
    AddPaymentView(payment: .constant(nil), movement: .constant(.init(idUser: UUID(), total: 00.00, date: .now)), payments: .constant(.init()), actionUpdate: {}, type: .create)
}
