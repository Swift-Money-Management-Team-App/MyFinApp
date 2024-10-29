import SwiftUI

struct ToggleRow: View {
    
    @Binding var toggleValue: Bool
    var image: String
    var label: String
    var labelForegroundStyle: Color?
    var imageForegroundStyle: Color?
    
    var body: some View {
        Toggle(isOn: self.$toggleValue) {
            Label {
                Text(LocalizedStringKey(stringLiteral: self.label))
                    .foregroundStyle(self.labelForegroundStyle ?? .black)
            } icon: {
                Image(systemName:self.image)
                    .foregroundStyle(self.imageForegroundStyle ?? .black)
            }
        }
    }
}

#Preview {
    
    @Previewable @State var toggleValue = false
    ToggleRow(toggleValue: $toggleValue, image: "square.text.square", label: "Hello World")
}
