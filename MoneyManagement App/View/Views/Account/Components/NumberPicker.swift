import SwiftUI

struct NumberPicker: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var closeDay: Int
    
    init(closeDay: Binding<Int>) {
        self._closeDay = closeDay
    }
    
    var body: some View {
        NavigationStack {
            Picker("", selection: self.$closeDay) {
                ForEach(1...28, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(.wheel)
            .presentationDetents([.height(300)])
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Voltar") {
                        self.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NumberPicker(closeDay: .constant(1))
}
