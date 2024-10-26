import SwiftUI

struct Profile: View {
    
    private let caioLinkedin = URL(string: "https://www.google.com.br")!
    private let giovanniLinkedin = URL(string: "www.google.com.br")!
    private let rafaelLinkedin = URL(string: "www.google.com.br")!
    private let raquelLinkedin = URL(string: "www.google.com.br")!
    
    var body: some View {
        
        @Environment(\.openURL) var openURL
        
        NavigationView {
            VStack {
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.brightGold)
                        .frame(maxHeight: 175)
                    
                    List {
                        
                        Link(destination: caioLinkedin) {
                            Label {
                                VStack (alignment: .leading) {
                                    Text("Caio Oliveira Marques")
                                    Text("Developer")
                                        .fontWeight(.thin)
                                        .font(.footnote)
                                }
                            } icon: {
                                Image(systemName: "person")
                            }
                        }
                        
                        Button {
                            openURL(caioLinkedin)
                        } label: {
                            Label {
                                VStack (alignment: .leading) {
                                    Text("Caio Oliveira Marques")
                                    Text("Developer")
                                        .fontWeight(.thin)
                                        .font(.footnote)
                                }
                                Spacer()
                                Image(systemName: "chevron")
                            } icon: {
                                Image(systemName: "person")
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
        .navigationTitle(LocalizedStringKey(stringLiteral: "Desenvolvedores"))
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    Profile()
}
