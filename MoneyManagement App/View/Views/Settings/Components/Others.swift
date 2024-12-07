import SwiftUI

struct Others: View {
    @Binding var isShowOnboarding: Bool
    
    var body: some View {
        ToggleRow(
            toggleValue: self.$isShowOnboarding,
            image: "square.text.square",
            label: .othersWelcomeScreenToggle, 
            imageForegroundStyle: .accent
        )
        .onChange(of: isShowOnboarding) {
            Storage.share.firstLaunchApplication = true
        }
    }
}

#Preview {
    @Previewable @State var toggleValue = false
    Others(isShowOnboarding: $toggleValue)
}
