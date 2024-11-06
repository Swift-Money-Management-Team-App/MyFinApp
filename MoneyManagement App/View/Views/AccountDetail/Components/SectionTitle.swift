import SwiftUI

struct SectionTitle: View {
    var text : String
    
    var body: some View {
        Text(text)
            .padding(.horizontal)
            .fontWeight(.bold)
            .foregroundStyle(.darkPink)
            .padding(.vertical)
    }
}

#Preview {
    SectionTitle(text: "Oi")
}
