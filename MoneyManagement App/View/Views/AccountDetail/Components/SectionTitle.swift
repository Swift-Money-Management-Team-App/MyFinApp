//
//  SectionTitle.swift
//  MoneyManagement App
//
//  Created by Caio Marques on 02/11/24.
//

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
