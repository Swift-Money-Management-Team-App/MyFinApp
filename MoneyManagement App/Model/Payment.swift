import Foundation
import SwiftData

@Model
final class Payment {
    
    #Unique<Payment>([\.id], [])
    
    var id: UUID
    var idMovement: UUID
    var idMethod: UUID
    var value: Double
    var competence: Date?
    
    init(idMovement: UUID, idMethod: UUID, origin: UUID, value: Double, competence: Date? = nil) {
        self.id = UUID()
        self.idMovement = idMovement
        self.idMethod = idMethod
        self.value = value
        self.competence = competence
    }
    
}
