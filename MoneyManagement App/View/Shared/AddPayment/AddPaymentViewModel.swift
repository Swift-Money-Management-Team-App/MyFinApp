import Foundation
import SwiftUI
import SwiftData

enum AddPaymentType {
    case create
    case update
}

extension AddPaymentView {
    
    func addPayment() {
        if self.account!.isCreditCard {
            self.payments.append(.init(idAccount: self.account!.id, idMovement: self.movement!.id, idMethod: self.method!.id, value: self.value, time: self.time, competence: self.competence))
        } else {
            self.payments.append(.init(idAccount: self.account!.id, idMovement: self.movement!.id, idMethod: self.method!.id, value: self.value, time: self.time))
        }
    }
    
    func changePayment() {
        self.payment?.idAccount = self.account!.id
        self.payment?.idMethod = self.method!.id
        self.payment?.value = self.value
        self.payment?.time = self.time
        if self.account!.isCreditCard {
            self.payment?.competence = self.competence
        } else  {
            self.payment?.competence = nil
        }
    }
    
}
