//
//  ContentViewModel.swift
//  MoneyManagement App
//
//  Created by Caio Marques on 15/10/24.
//

import Foundation
import SwiftUI
import SwiftData

extension HomeView {
    @Observable
    class HomeViewModel : ObservableObject {
        
        let modelContenxt: ModelContext
        var user: [User] = []
        var isShowingScreenName: Bool = true
        var personName: String = ""
        
        init(modelContenxt: ModelContext) {
            self.modelContenxt = modelContenxt
            self.fetchUser()
        }
        
        func fetchUser() {
            do {
                self.user = try modelContenxt.fetch(FetchDescriptor<User>(sortBy: [.init(\.name)]))
            } catch {
                print("Deu ruim 1")
            }
        }
        
        func appendUser() {
            self.modelContenxt.insert(User(name: self.personName))
            do {
                try modelContenxt.save()
            } catch {
                print("Deu ruim 2")
            }
            self.fetchUser()
            self.isShowingScreenName = false
        }
        
    }

}
