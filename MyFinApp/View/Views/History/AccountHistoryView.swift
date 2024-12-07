import SwiftUI
import SwiftData

struct AccountHistoryView: View {
    
    private let bankName = "Itaú" // TODO: REMOVER DEPOIS QUE PASSAR OS DADOS
    let account: Account
    @Query var payments: [Payment]
    @Query var movements: [Movement]
    @Query var expenseCategories: [ExpenseCategory]
    @Query var earningCategories: [EarningCategory]
    @State var movementsToRead: [Movement] = []
    @State var total: Double = 0
    @State private var segmentedPickerSelection: HistoryDateFilter = .lastMonth
    @State private var filterPickerSelection: OrderByFilter = .AscendingAlphabetical
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { layout in
                ScrollView {
                    VStack (alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.brightGold)
                            .overlay(alignment: .bottomLeading) {
                                Text("Histórico - \(self.account.name)")
                                    .font(.largeTitle)
                                    .bold()
                                    .padding()
                            }
                            .frame(height: 175)
                        
                        Picker("", selection: self.$segmentedPickerSelection) {
                            ForEach(HistoryDateFilter.allCases, id: \.self) {
                                option in
                                Text(option.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.top, 44)
                        .padding([.leading, .trailing], 10)
                        
                        Menu() {
                            Picker("", selection: self.$filterPickerSelection) {
                                ForEach(OrderByFilter.allCases, id: \.self) {
                                    option in
                                    Button(option.rawValue) {
                                        // TODO: ADICIONAR LÓGICA DOS FILTROS
                                    }
                                }
                            }
                        } label: {
                            Button(action: {}) {
                                Text("Filtros")
                                    .foregroundStyle(.white)
                            }
                            .buttonStyle(.bordered)
                            .background(Color("Onboarding/ButtonColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.leading, 10)
                            .padding(.top, 20)
                        }
                        
                        Text("Saldo Total")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        List {
                            ValueRow(value: self.account.total)
                        }
                        .frame(height: 42)
                        .scrollDisabled(true)
                        .listStyle(.inset)
                        
                        Text("Movimentações")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                            .padding(.top, 20)
                        List {
                            ForEach(self.movementsToRead) { movement in
                                let payments = self.payments.filter({ payment in payment.idMovement == movement.id })
                                let total: Double = self.totalMovements(earned: movement.earningCategory != nil, payments: payments)
                                let time: Date = self.oldTime(payments: payments)
                                
                                BankStatementRow(
                                    description: movement.transactionDescription ?? "Sem descrição",
                                    value: total,
                                    icon: movement.expenseCategory != nil ? self.expenseCategories.filter({ category in category.id == movement.expenseCategory }).first!.emoji : self.earningCategories.filter({ category in category.id == movement.earningCategory }).first!.emoji,
                                    day: movement.date.formatted(.dateTime.day()),
                                    time: time.formatted(.dateTime
                                        .hour(.twoDigits(amPM: .omitted))
                                        .minute(.twoDigits)
                                    )
                                )
                            }
                        }
                        .listStyle(.inset)
                        .frame(height: layout.size.height - 550)
                        
                    }
                }
                .background(Color.background)
            }
        }
        .onAppear {
            self.allMovements()
        }
        .ignoresSafeArea()
        .toolbarBackground(.hidden)
    }
}

#Preview {
    AccountHistoryView(account: .init(idBankAccount: .init(), name: "Safade"))
}
