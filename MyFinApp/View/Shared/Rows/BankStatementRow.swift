import SwiftUI

struct BankStatementRow: View {
    
    var description: String
    var value: Double
    var icon: String
    var day: String
    var time: String
    
    var body: some View {
        Label {
            HStack {
                VStack (alignment: .leading) {
                    Text(self.description)
                        .font(.body)
                    Text("R$ \(String(format: "%.2f", self.value))")
                        .foregroundStyle(value > 0 ? Color.green : Color.red)
                        .font(.footnote)
                }
                Spacer()
                VStack (alignment: .trailing){
                    Text(self.day)
                        .font(.body)
                        .foregroundStyle(.gray)
                    Text(self.time)
                        .foregroundStyle(.gray)
                        .font(.footnote)
                }
            }
        } icon: {
            Image(systemName: self.icon)
                .foregroundStyle(Color.black)
        }
        .frame(height: 20)
    }
}

#Preview {
    BankStatementRow(description: "Adiantamento de Salário", value: 50.50, icon: "dollarsign.square", day: "22", time: "09:41")
}
