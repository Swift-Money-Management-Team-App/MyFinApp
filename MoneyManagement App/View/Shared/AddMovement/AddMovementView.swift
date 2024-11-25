import SwiftUI
import SwiftData

struct AddMovementView: View {
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var earningCategories: [EarningCategory]
    @Query var expenseCategories: [ExpenseCategory]
    // Entrada de Dados
    @State var account: Account? = nil
    @State var bankAccount: BankAccount? = nil
    @State var date: Date = .now
    @State var description: String = ""
    @State var earningCategory: EarningCategory? = nil
    @State var expenseCategory: ExpenseCategory? = nil
    @State var total: Double = 0.00
    @State var time: Date = .now
    @State var payments: [Payment] = []
    // Dados para visualização
    @State var earned: Bool = Storage.share.earned
    @State var moved: Bool = false
    // Booleans para visualização
    @State var screenFullEarningCategory: Bool = false
    @State var screenFullExpenseCategory: Bool = false
    @State var screenFullPayment: Bool = false
    @State var alertCancel: Bool = false
    
    var body: some View {
        List {
            Section {
                Toggle(isOn: $earned) {
                    Text("Ganho")
                }
                .onChange(of: earned) { _, _ in
                    Storage.share.earned.toggle()
                    self.moved = true
                }
                Label(title: {
                    DatePicker("Data", selection: $date, displayedComponents: [.date])
                }, icon: {})
                .onChange(of: date) { _, _ in
                    self.moved = true
                }
                .labelStyle(.titleOnly)
                if earned {
                    Picker("Categoria", selection: $earningCategory) {
                        ForEach(self.$earningCategories) { earningCategory in
                            Label(earningCategory.name, systemImage: earningCategory.emoji)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } else {
                    Picker("Categoria", selection: $expenseCategory) {
                        ForEach(self.$expenseCategories) { expenseCategory in
                            Label(expenseCategory.name, systemImage: expenseCategory.emoji)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                VStack {
                    Text("Descrição")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Tutorial do IRSS", text: $description, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                        .textFieldStyle(.roundedBorder)
                }
                .onChange(of: description) { _, _ in
                    self.moved = true
                }
            }
            Section (content: {
                NavigationLink(destination: {}) {
                    HStack {
                        Text("Categoria")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        // TODO: Colocar categorias
                        Text("R$ 700,00")
                            .foregroundStyle(.gray)
                    }
                }
            }, header: {
                HStack {
                    Text("Pagamentos")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.darkPink)
                        .fontWeight(.semibold)
                    Button(action: { self.screenFullPayment.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            })
            .onChange(of: payments) { _, _ in
                self.moved = true
            }
            Section {
                Label {
                    HStack {
                        Text("Total")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("R$ \(self.total.formatToCurrency)")
                    }
                } icon: {}
            }
        }
        .listStyle(.grouped)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .background(Color.background)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                    if self.moved {
                        self.alertCancel.toggle()
                    } else {
                        Navigation.navigation.screens.removeLast()
                    }
                }) {
                    Text("Cancelar")
                }
            }
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Nova movimentação")
                    
                }
            }
            ToolbarItem {
                Button(action: {}) {
                    Text("Adicionar")
                }
            }
        }
        .alert("Tem certeza de que deseja descartar estas alterações?", isPresented: $alertCancel) {
            Button("Continuar Editando", role: .cancel) { self.alertCancel.toggle() }
                .tint(.blue)
            Button("Descartar Alterações", role: .destructive) { Navigation.navigation.screens.removeLast() }
        }
        .fullScreenCover(isPresented: $screenFullPayment) { AddPaymentView(type: .create) }
    }
}

#Preview {
    AddMovementView()
}
