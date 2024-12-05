import SwiftUI

struct SharedLinkRow {
    
    @ViewBuilder
    func createSharedLinkRow(url: URL, label: String, labelForegroundStyle: Color, isShowDisclosureIcon: Bool = false, iconSystemName: String, iconForegroundStyle: Color) -> some View {
        
        ShareLink(item: url) {
            Label {
                HStack {
                    Text(LocalizedStringResource(stringLiteral: label))
                        .foregroundStyle(labelForegroundStyle)
                    
                    if isShowDisclosureIcon {
                        createDisclosureIcon()
                    } else {
                        EmptyView()
                    }
                }
            } icon: {
                Image(systemName: iconSystemName)
                    .foregroundStyle(iconForegroundStyle)
            }
        }
    }
    
    @ViewBuilder
    private func createDisclosureIcon(fontSize: CGFloat? = 14) -> some View {
        Spacer()
        Image(systemName: "chevron.right")
            .font(.system(size: 14, weight: .bold))
            .foregroundStyle(.accent)
    }
}
