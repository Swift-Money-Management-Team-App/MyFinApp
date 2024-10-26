import SwiftUI

struct Others: View {
    
    @Binding var isShowOnboarding: Bool
    
    var body: some View {
        ToggleRow(toogleValue: self.$isShowOnboarding, image: "square.text.square", label: "Tela de boas vindas")
    }
}

#Preview {
    @Previewable @State var toggleValue = false
    Others(isShowOnboarding: $toggleValue)
}
