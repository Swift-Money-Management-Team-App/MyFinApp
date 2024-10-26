import SwiftUI

struct ToggleRow: View {
    
    @Binding var toogleValue: Bool
    var image: String
    var label: String
    
    var body: some View {
        Toggle(isOn: self.$toogleValue) {
            Label(self.label, systemImage: self.image)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    
    @Previewable @State var toggleValue = false
    ToggleRow(toogleValue: $toggleValue, image: "square.text.square", label: "Hello World")
}
