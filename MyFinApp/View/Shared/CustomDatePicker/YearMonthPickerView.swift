import SwiftUI

struct YearMonthPickerView: View {
    @Binding var selectedDate: Date
    
    let months: [String] = Calendar.current.shortMonthSymbols
    let columns = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        VStack {
            //year picker
            HStack {
                Image(systemName: "chevron.left")
                    .frame(width: 24.0)
                    .onTapGesture {
                        var dateComponent = DateComponents()
                        dateComponent.year = -1
                        selectedDate = Calendar.current.date(byAdding: dateComponent, to: selectedDate)!
                        print(selectedDate)
                    }
                
                Text("\(String(getYear(from: selectedDate)))")
                    .fontWeight(.bold)
                    .transition(.move(edge: .trailing))
                
                Image(systemName: "chevron.right")
                    .frame(width: 24.0)
                    .onTapGesture {
                        var dateComponent = DateComponents()
                        dateComponent.year = 1
                        selectedDate = Calendar.current.date(byAdding: dateComponent, to: selectedDate)!
                        print(selectedDate)
                    }
            }
            .padding(15)
            
            //month picker
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(months, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .frame(width: 60, height: 33)
                        .bold()
                        .background(item == getMonth(from: self.selectedDate) ?  Color.blue : Color.white)
                        .cornerRadius(8)
                        .onTapGesture {
                            var dateComponent = DateComponents()
                            dateComponent.day = 1
                            dateComponent.month =  months.firstIndex(of: item)! + 1
                            dateComponent.year = Int(getYear(from: selectedDate))
                            selectedDate = Calendar.current.date(from: dateComponent)!
                        }
                }
            }
            .padding(.horizontal)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom)
        .background(Color.background)
        .presentationDetents([.height(250)])
    }
    
    func getYear(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self.selectedDate)
    }
    
    func getMonth(from date: Date) -> String {
        let calendar = Calendar.current
        return calendar.shortMonthSymbols[calendar.component(.month, from: self.selectedDate) - 1]
    }
    
}

#Preview {
    YearMonthPickerView(selectedDate: .constant(.now))
}
