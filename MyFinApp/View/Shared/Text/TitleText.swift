import SwiftUI

struct TitleText {
        
    @ViewBuilder
    func createTitleText(_ text: String) -> some View {
        Text(text)
            .font(.system(.headline))
            .padding([.top, .bottom])
    }
}
