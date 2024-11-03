//
//  EditFinancialInstitution.swift
//  MoneyManagement App
//
//  Created by Caio Marques on 02/11/24.
//

import SwiftUI

struct EditFinancialInstitution: View {
    @Environment(\.dismiss) var dismiss
    @State var showAlertDiscard : Bool = false
    @State var showAlertDelete : Bool = false
    @State var name : String = ""
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            Spacer()
            SectionTitle(text: "Qual o nome da instituição financeira")
            
            Rectangle()
                .foregroundStyle(.backgroundColorRow)
                .frame(height: 80)
                .overlay {
                    VStack {
                        HStack (spacing: 30){
                            Text("Nome")
                            TextField("Itaú", text: $name)
                        }
                        Divider()
                            .padding(.horizontal)
                        
                        if name.isEmpty {
                            Button (role: .destructive) {
                                showAlertDelete = true
                            } label: {
                                Text("Apagar instituição financeira")
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            Spacer()
        }
        .ignoresSafeArea()
        .background(Color.background)
        .navigationTitle("Instituição financeira")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button ("Voltar") {
                    showAlertDiscard = true
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button ("Editar") {
                    
                }
            }
        }
        .alert("Você tem certeza de que deseja descartar essas alterações", isPresented: $showAlertDiscard) {
            
            Button (role: .destructive) {
                dismiss()
            } label: {
                Text("Descartar Alterações")
            }
            
            Button(role: .cancel) {} label: {
                Text("Continuar editando")
            }
        }
        .alert("Você tem certeza de que deseja apagar essa Conta Bancária?", isPresented: $showAlertDelete) {
            
            Button (role: .destructive) {
                dismiss()
            } label: {
                Text("Apagar instituição financeira")
            }
            
            Button(role: .cancel) {} label: {
                Text("Cancelar")
            }
        } message: {
            Text("Ao deletar uma Instituição Financeira, você irá apagar todas as transações, todas contas e todo o histórico.")
            Text("Essa ação é permanente e não poderá ser desfeita!")
                .bold()
        }

    }
}

#Preview {
    @Previewable @State var bankName : String = ""
    EditFinancialInstitution()
        .sheet(isPresented: .constant(true)) {
            NavigationStack {
                EditFinancialInstitution()
            }
                .presentationDetents([.fraction(0.3)])
        }

        
}
