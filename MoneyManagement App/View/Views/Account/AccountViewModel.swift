import SwiftUI

extension AccountView {
    
    func allMovements() {
        let payments = self.payments.filter({ payment in payment.idAccount == self.account.id })
        var idsMovement: [UUID] = []
        for payment in payments {
            idsMovement.append(payment.idMovement)
        }
        idsMovement = idsMovement.uniqued()
        var movements: [Movement] =  []
        for id in idsMovement {
            movements.append(self.movements.filter({ movement in movement.id == id }).first!)
        }
        self.movementsToRead = movements
    }
    
    func totalMovements(earned: Bool, payments: [Payment]) -> Double {
        var total: Double  = 0
        for payment in payments {
            if earned {
                total += payment.value
            } else {
                total -= payment.value
            }
        }
        return total
    }
    
    func oldTime(payments: [Payment]) -> Date {
        var time: Date? = nil
        for payment in payments {
            if time == nil {
                time = payment.time
            } else if time! < payment.time {
                time = payment.time
            }
        }
        return time!
    }
    
}
