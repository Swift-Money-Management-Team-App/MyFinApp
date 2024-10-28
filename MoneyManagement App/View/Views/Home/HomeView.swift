//
//  HomeView.swift
//  MoneyManagement App
//
//  Created by Raquel on 10/10/24.
//

import SwiftUI
import SwiftData
import CoreData

struct HomeView: View {
    
    @ObservedObject var viewModel : HomeViewModel
    
    init(modelContext: ModelContext) {
        self.viewModel = HomeViewModel(modelContenxt: modelContext)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.user) { user in
                Text("\(user.name)")
            }
        }
        .sheet(isPresented: $viewModel.isShowingScreenName, onDismiss: {}, content: {
            VStack {
                HStack {
                    Button(action: {
                        viewModel.appendUser()
                    }) {
                        Text("Confirmar")
                            .padding(10)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding([.top, .trailing], 10)
                VStack {
                    Text("Como gostaria de ser chamado?")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField(text: $viewModel.personName, label: {
                        Text("Nome")
                    })
                    .frame(maxWidth: .infinity)
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundStyle(Color("Home/ModalLine"))
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 40)
            }
            .presentationDetents([.height(200)])
            .interactiveDismissDisabled(true)
        })
    }
}

#Preview {
    HomeView(modelContext: try! ModelContainer(for: User.self, BankAccount.self).mainContext)
}
