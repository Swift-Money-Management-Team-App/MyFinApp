import SwiftUI

struct AllHistoryView: View {
    
    @State private var segmentedPickerSelection: HistoryDateFilter = .lastMonth
    
    @State private var filterPickerSelection: OrderByFilter = .AscendingAlphabetical
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
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
                            // TODO: COLOCAR OS VALORES VARIÁVEIS AQUI
                            ValueRow(value: 500.50)
                        }
                        .frame(height: 42)
                        .scrollDisabled(true)
                        .listStyle(.inset)
                        
                        Text(LocalizedStringKey.totalBalance.label)
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                            .padding(.top, 20)
                        List {
                            // TODO: COLOCAR O FOR EACH AQUI
                            
                            NavigationLink {
                                // TODO: COLOCAR O DESTINO DA VIEW PRA PODER ABRIR A INSTITUIÇÃO FINANCEIRA
                                Text("a")
                            } label: {
                                HStack {
                                    // TODO: ADICIONAR OS NOMES DE ACORDO COM A LISTA
                                    Text("Itaú")
                                    Spacer()
                                    // TODO: ADICIONAR O VALOR DE ACORDO COM A LISTA
                                    Text("R$ 900,00")
                                }
                            }
                        }
                        .scrollDisabled(true)
                        .listStyle(.inset)
                        .frame(height: 300)
                    }
                }
                .background(Color.background)
            }
            .ignoresSafeArea()
            .toolbarBackground(.hidden)
        }
    }
}

#Preview {
    AllHistoryView()
}
