//
//  UsernameView.swift
//  MoneyManagement App
//
//  Created by Caio Marques on 28/10/24.
//

import SwiftUI

struct UsernameView: View {
    @Binding var isOpen : Bool
    @AppStorage("username") var name : String = ""
    let characterLimit : Int = 12
    
    var nameCharacterCount : Int {
        name.count
    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Spacer()
                Text("Como gostaria de ser chamado?")
                    .fontWeight(.semibold)
                    .foregroundStyle(.darkPink)
                    .padding(.horizontal)
                
                
                Rectangle()
                    .frame(height: 55)
                    .foregroundStyle(.white)
                    .overlay {
                        HStack {
                            Text("Nome")
                                .padding(.trailing, 30)
                            TextField("Filipe", text: $name)
                                .onChange(of: name) { oldValue, newValue in
                                    if newValue.count > characterLimit {
                                        name = oldValue
                                    }
                                }
                            
                            if !name.isEmpty {
                                Button {
                                    name = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                .foregroundStyle(.secondary)
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                
                HStack {
                    Spacer()
                    Text("\(self.nameCharacterCount)/\(characterLimit)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)

                }
                
                Spacer()
                Spacer()
            }
            .navigationTitle("Adicionar usuário")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button ("Confirmar") {
                        isOpen = false
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
        
    }
}

#Preview {

    VStack {
        
    }.sheet(isPresented: .constant(true)) {
        UsernameView(isOpen: .constant(true))
            .presentationDetents([.fraction(0.33)])
    }
}
