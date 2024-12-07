import SwiftUI
import SwiftData

struct AllHistoryView: View {
    
    @Query var bankAccounts: [BankAccount]
    @State private var segmentedPickerSelection: HistoryDateFilter = .lastMonth
    @State private var filterPickerSelection: OrderByFilter = .AscendingAlphabetical
    @State var total: Double = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { layout in
                ScrollView {
                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.brightGold)
                            .overlay(alignment: .bottomLeading) {
                                Text(LocalizedStringKey.allHistoryTitle.label)
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
                        
                        Menu {
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
                                Text(LocalizedStringKey.filters.label)
                                    .foregroundStyle(.white)
                            }
                            .buttonStyle(.bordered)
                            .background(Color("Onboarding/ButtonColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.leading, 10)
                            .padding(.top, 20)
                        }
                        
                        Text(LocalizedStringKey.totalBalance.label)
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        List {
                            ValueRow(value: self.total)
                        }
                        .frame(height: 42)
                        .scrollDisabled(true)
                        .listStyle(.inset)
                        
                        Text(LocalizedStringKey.homeFinancialInstitutions.label)
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                            .padding(.top, 20)
                        List {
                            ForEach(self.bankAccounts) { bankAccount in
                                NavigationLink(value: NavigationScreen.bankHistory(bankAccount: bankAccount)) {
                                    HStack {
                                        Text(bankAccount.name)
                                        Spacer()
                                        Text("R$ \(NumberFormatter().formatToCurrency.string(for: bankAccount.total)!)")
                                    }
                                }
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
            self.totalBankAccounts()
        }
        .ignoresSafeArea()
        .toolbarBackground(.hidden)
    }
}

#Preview {
    AllHistoryView()
}
